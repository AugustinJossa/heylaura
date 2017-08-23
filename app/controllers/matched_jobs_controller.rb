class MatchedJobsController < ApplicationController

	def index
		@matched_jobs = MatchedJob.all
	end

	
end
