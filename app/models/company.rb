class Company < ApplicationRecord
  has_many :jobs
  has_many :matched_jobs, through: :jobs
end
