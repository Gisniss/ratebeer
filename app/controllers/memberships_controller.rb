class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @clubs = BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    club = params.require(:membership).permit(:beer_club_id)
    club_id = club[:beer_club_id]
    user_id = params[:user_id]
    cl = BeerClub.find_by id:club_id
    users = cl.users
    us = User.find_by id:user_id
  if users.include?(us)
	redirect_to new_membership_path, notice: "You are already a member of #{cl.name}"
  else
	@membership = Membership.new params.require(:membership).permit(:user_id, :beer_club_id)
	if @membership.save
	  current_user.memberships << @membership
	  redirect_to user_path current_user
	else
	  @clubs = BeerClub.all
	  render :new
	end
  end

   
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:beer_club_id, :user_id)
    end
end
