class JobsController < ApplicationController

  before_action :set_job, only: [:show]

  def index
    @jobs = policy_scope(Job).order(created_at: :desc)
  end

  def show
  end
end

def set_job
  Job.find(parals[:id])
end

