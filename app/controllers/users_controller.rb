class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		authorize @user
		return @matched_jobs = MatchedJob.where(user_id: @user.id)
	end


	def filter_by_status
		@user = User.find(params[:id])
		authorize @user
		binding.pry
		status = "Bookmarked"
		@mj_status = MatchedJob.where(user_id: @user.id, status: status)
	end




end
