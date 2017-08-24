class Profile < ApplicationRecord
  belongs_to :user
  has_many :motivation_rankings
  has_many :profile_skills
  has_many :matched_jobs
end
