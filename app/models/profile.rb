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
    filter_params["raw_chat_content"] = params.to_json
    return filter_params
  end

  def find_match_jobs
    p = self
    Job.all.each do |job|
      mj = MatchedJob.new(
        profile: p,
        job: job,
        matching: rand(1..100).fdiv(100)
       )
      puts mj.valid?
      mj.save
    end
  end

end
