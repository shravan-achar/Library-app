# require '../helpers/bookings_helper'

class BookingsController < ApplicationController
  # before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  include BookingsHelper

  # GET /bookings
  # GET /bookings.json
  def index


    @bookings = Booking.all
    rooms = Room.all

    @rooms_array = {"None"=>[["Any", 0]],"Hunt"=>[],"DH Hill"=>[]}#To be used for selector in the view
    rooms.each do |r|
      r_str = "Room "<<r[:number].to_s
      if r[:building].to_i==0
        @rooms_array["Hunt"]<<[r_str, r[:id]]
      else
        @rooms_array["DH Hill"]<<[r_str, r[:id]]
      end
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    session[:booking_time] =  params[:booking_time]
    session[:room_id] = params[:room_id]
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create

    @booking = Booking.new
    @booking[:room_id] = session[:room_id]
    @booking[:Participants] = params[:participants]
    @booking[:StartTime] = session[:booking_time]
    @booking[:EndTime] = (Time.parse(session[:booking_time])+2.hours).strftime("%Y-%m-%d %H:%M:%S")

    if isAdmin
      @booking[:member_id] = Member.where(:email=>params[:organizer].strip)[0][:id]
    else
      @booking[:member_id] = getUserId
    end

    respond_to do |format|
      if @booking.save
        format.html { redirect_to bookings_url, notice: '<strong>Success!</strong> Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
        invite_participants
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search

    inner_q = "SELECT DISTINCT room_id FROM bookings WHERE"
    outer_q = "SELECT * FROM rooms WHERE"

    #Room number
    if params[:room].to_i>0
      outer_q<<" id = "<<params[:room].to_s<<" AND"
    end

    #Room number
    if params[:room_size].to_i>0
      outer_q<<" capacity = "<<params[:room_size].to_s<<" AND"
    end

    #Timing
    @booking_time = Time.parse(params[:bookingdate].to_s<<" "<<params[:bookingtime].to_s)
    cur_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    inner_q << " (StartTime < \""<<(@booking_time+2.hours).strftime("%Y-%m-%d %H:%M:%S")<<"\" AND EndTime > \""<<@booking_time.strftime("%Y-%m-%d %H:%M:%S")<<"\")"

    q = "SELECT * FROM rooms WHERE id NOT IN ("<<inner_q<<")"
    outer_q<<" id NOT IN ("<<inner_q<<")"

    @s3 = Booking.find_by_sql(inner_q)
    @search_results = Booking.find_by_sql(outer_q)

    puts 'l'
  end


  def makebooking
    return
end

  def quickbook
    inner_q = "SELECT DISTINCT room_id FROM bookings WHERE"
    outer_q = "SELECT * FROM rooms WHERE"

    #Room number
    if params[:room_id].to_i>0
      outer_q<<" id = "<<params[:room_id].to_s<<" AND"
    end

    #Timing
    @booking_time = Time.parse(params[:booking_date].to_s<<" "<<params[:booking_time].to_s)
    cur_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    inner_q << " (StartTime < \""<<(@booking_time+2.hours).strftime("%Y-%m-%d %H:%M:%S")<<"\" AND EndTime > \""<<@booking_time.strftime("%Y-%m-%d %H:%M:%S")<<"\")"

    q = "SELECT * FROM rooms WHERE id NOT IN ("<<inner_q<<")"
    outer_q<<" id NOT IN ("<<inner_q<<")"

    @s3 = Booking.find_by_sql(inner_q)
    @search_results = Booking.find_by_sql(outer_q)

    if(@search_results.size!=1)
      redirect_to bookings_makebooking_url, notice: "No slots available. Please use search"
      return
    end

    #Add to database
    @booking = Booking.new
    @booking[:room_id] = params[:room_id]
    @booking[:Participants] = params[:participants]
    @booking[:StartTime] = @booking_time.strftime("%Y-%m-%d %H:%M:%S")
    @booking[:EndTime] = (@booking_time+2.hours).strftime("%Y-%m-%d %H:%M:%S")

    if isAdmin
      @booking[:member_id] = Member.where(:email=>params[:organizer].strip)[0][:id]
    else
      @booking[:member_id] = getUserId
    end

    invite_participants

    if @booking.save
      redirect_to bookings_makebooking_url, notice: 'Booking was successfully created.'
    else
      format.html { render :new }
      format.json { render json: @booking.errors, status: :unprocessable_entity }
    end

    puts 'l'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:RoomId, :participant, :Member, :StartTime, :EndTime, :Booked)
    end

    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_login_url # halts request cycle
      end
    end

    def invite_participants
      participants = @booking[:Participants].split(%r{,\s*})
      organizer = Member.find(@booking[:member_id])[:name]
      r = Room.find(@booking[:room_id])
      bld = r[:building].to_i==0 ? "Hunt" : "DH Hill"
      room = "Room "<< r[:number].to_s << " (" << bld << ")"

      participants.each do |p|
        p=p.strip
        m = Member.where(:email=>p)

        if(m.size>0)
          m=m[0]
          msg = "You have been invited by "<<organizer<<" for a meeting in "<<room<<" at "<<@booking[:StartTime].to_s
          m[:notification]= msg
          m.save
        end
      end
    end

end
