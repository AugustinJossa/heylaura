class Profile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :motivation_rankings
  has_many :profile_skills
  has_many :matched_jobs

  def filter_chat_info(params)
    object_keys = JSON.parse(self.to_json).keys
    filter_params = params.select do |key, index|
      object_keys.include?(key)
    end
    return filter_params
  end

end
