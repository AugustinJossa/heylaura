class Job < ApplicationRecord
  has_many :matched_jobs
  belongs_to :company
end
