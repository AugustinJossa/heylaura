class MatchedJobsController < ApplicationController

  before_action :set_job, only: [:show]
  before_action :categories, only: [:index]

  def index
    @jobs = policy_scope(Job).order(created_at: :desc)
  end


  def show

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



end
