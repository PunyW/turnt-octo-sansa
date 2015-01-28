class MembershipsController < ApplicationController
  def new
    @clubs = BeerClub.all
    @membership = Membership.new
  end

  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)

    if @membership.save
      if current_user.memberships.find_by(beer_club_id: params[:membership][:beer_club_id]).nil?
        current_user.memberships << @membership
        redirect_to user_path current_user
      else
        redirect_to user_path current_user
      end
    else
      @clubs = BeerClub.all
      render :new
    end
  end
end