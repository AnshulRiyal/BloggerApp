class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    authorize User
    @users = User.all
    # @users = policy_scope(User)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize User
    @user = User.find params[:id]
  end

  # GET /users/new
  def new
    # Removed the registerable module from devise to make it work.
    # authorize User
    # @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize User
    @user = User.find params[:id]
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find params[:id]
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find params[:id]
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  #allowing access to current user logged in
  def require_login
    unless current_user
      redirect_to new_user_session_path
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :status, role_ids: [])
  end
end
