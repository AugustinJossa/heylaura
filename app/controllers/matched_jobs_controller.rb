class MatchedJobsController < ApplicationController

  before_action :set_job, only: [:show]
  before_action :categories, only: [:index]

  def index
    @jobs = policy_scope(Job).order(created_at: :desc)
  end


  def show
    @matched_job = MatchedJob.find(params[:id])
    authorize @matched_job

  end


  private


  def set_job
    @job = Job.find(params[:id])
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
