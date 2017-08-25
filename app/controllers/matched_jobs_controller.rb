class MatchedJobsController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :categories, only: [:index]

  def index
    raise
    @matched_jobs = policy_scope(MatchedJob).order(created_at: :desc)
    @matched_jobs = MatchedJob.where(profile_id:2)
  end


  def show
    @matched_job = MatchedJob.find(params[:id])
    authorize @matched_job

  end

  def filter

  end


  private


  def set_profile
    @profile = Profile.find(params[:id])
  end

  #liste des catégories pour le formulaire de filtres
  def categories
      @job_types = Job.select(:job_type).distinct.map do |job|
        job.job_type
      end
      @contracts = Job.select(:contract).distinct.map do |job|
        job.contract
      end
  end

  # récupération des params de mon form (attention à bien créer une route pour sauver les params)
  def filter_jobs_params
    params.require(:query).permit(:job_type, :contract, :salary, :industry, :company_type, :size, :location)
  end

  # def params pour instancier matched_job dans la show
  def matched_job_params
    params.require(:matched_job).permit(:matching, :status, :message, :job_id, :user_id)
  end

end
