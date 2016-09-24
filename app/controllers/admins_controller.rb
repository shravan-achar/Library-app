class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    id = params[:id]
    @admin = Admin.find(id)
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_url, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admins_url, notice: 'Admin ' + @admin._read_attribute(:name) + ' was successfully updated.' }
        format.json { render :index, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    respond_to do |format|
      id = @admin._read_attribute(:id)
      if (id == 1)
        format.html {redirect_to admins_url, notice: 'Operation not permitted'}
      elsif @admin.destroy
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed' }
      format.json { head :index, status: ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end

    end
  end

  # POST   /admin/addmember
  # POST   /admin/addmember.json

  def addmember
  end

  def options
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def logged_in?
      return true
    end

    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :password)
    end

    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
      redirect_to new_login_url # halts request cycle
    end
  end
end
