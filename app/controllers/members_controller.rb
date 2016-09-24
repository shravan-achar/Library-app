class MembersController < ApplicationController

  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def show
  	@member = Member.find(params[:id])
  end
  

  # GET /members
  # GET /members.json
  def index
    redirect_to controller: 'bookings', action: 'makebooking'
  end

  def showall
    @members = Member.all
  end

  def history
    @booking_list = @member.bookings
  end
  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
  	@member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
      	flash[:success] = "Welcome to the Library App!"
	format.html { redirect_to bookings_makebooking_url, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }

      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to bookings_makebooking_url, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      # Upon successful deletion redirect to login_page
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

  def logged_in?
    return true #Replace this with session variable
  end
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_login_url # halts request cycle
    end
  end

  def member_params
      params.require(:member).permit(:name, :email, :password, :password_confirmation)

      #params.require(:member).permit(:name, :email, :password, :password_confirmation)
  end
end
