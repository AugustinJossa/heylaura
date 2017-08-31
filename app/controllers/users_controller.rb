class UsersController < ApplicationController

	before_action :set_user_and_profile, only: [:show, :accepted ]

	def show
		@matched_jobs = MatchedJob.where(profile_id: @profile.id)
		status = ["Bookmarked", "Pending", "Accepted", "Rejected"]
		@mj_bookmarked = MatchedJob.where(profile_id: @profile.id, status: "Bookmarked").sort_by{|mj| mj.updated_at}.reverse
		@mj_pending = MatchedJob.where(profile_id: @profile.id, status: "Pending").sort_by{|mj| mj.updated_at}.reverse
		@mj_accepted = MatchedJob.where(profile_id: @profile.id, status: "Accepted").sort_by{|mj| mj.updated_at}.reverse
		@mj_rejected = MatchedJob.where(profile_id: @profile.id, status: "Rejected").sort_by{|mj| mj.updated_at}.reverse

	end


	def accepted
    	@mj_accepted = MatchedJob.where(profile_id: @profile.id, status: "Accepted")
  	end

  def manage_connection
    # binding.pry
    if current_user.profiles && current_user.profiles.length > 0
    # already a profil registered for this user > redirect on his last profile (ignore profil just created if any)
      flash[:notice] = "Welcome back. Voilà les offres correspondants à ton profil!"
      @profile = current_user.profiles.last
      authorize @profile
      redirect_to(profile_matched_jobs_path(@profile))
    elsif session[:profile_id] && Profile.find(session[:profile_id])
    # a profile has been registered in the session cookies > add it to the user
      flash[:notice] = "J'ai rattaché ton profil à ton compte. Bravo !"
      @profile = Profile.find(session[:profile_id])
      session[:profile_id] = nil
      @profile.user = current_user
      @profile.save
      authorize @profile
      redirect_to(profile_matched_jobs_path(@profile))
    else
    # no profile found > redirect to home
      flash[:alert] = "Je n'ai trouvé aucun profil correspondant à ton compte. Discutons ensemble."
      @user = current_user
      authorize @user
      redirect_to(root_path)
    end
  end



  private

	def set_user_and_profile
		@user = User.find(params[:id])
		authorize @user
		@profile = @user.profiles.last
	end
end
