class UsersController < ApplicationController

	before_action :set_user_and_profile
  after_save :set_user_in_profile

	def show
		@matched_jobs = MatchedJob.where(profile_id: @profile.id)

		status = ["Bookmarked", "Pending", "Accepted", "Rejected"]
		@mj_bookmarked = MatchedJob.where(profile_id: @profile.id, status: "Bookmarked")
		@mj_pending = MatchedJob.where(profile_id: @profile.id, status: "Pending")
		@mj_accepted = MatchedJob.where(profile_id: @profile.id, status: "Accepted")
		@mj_rejected = MatchedJob.where(profile_id: @profile.id, status: "Rejected")

	end


	# def filter_by_status(status)
	# 	@mj_bookmarked = MatchedJob.where(profile_id: @profile.id, status: status)
	# end
  private

	def set_user_and_profile
		@user = User.find(params[:id])
		authorize @user
		@profile = Profile.find(user_id = @user.id)

	end

  def set_user_in_profile
    @profile = Profile.find(session[:profile_id])
    profile.user = current_user
    profile.save
    redirect_to profile_matched_jobs_path(@profile)
  end

end
