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

  def add_motivation_rankings
    chat_content = JSON.parse(self.raw_chat_content)
    p = self
    motiv_categories_ary = []
    motiv_categories_ary = chat_content["motivationCategories"] if chat_content["motivationCategories"]
    motiv_categories_ary << chat_content["motivLastCat"] if chat_content["motivLastCat"]
    motiv_categories_ary.each_with_index do |value, index|
      mr = MotivationRanking.new(
        profile: p,
        motivation_category: MotivationCategory.find_by(name: value),
        position: index + 1)
      mr.save
    end
  end

  def create_matched_jobs
    p = self
    Job.all.each do |job|
      mj = MatchedJob.new(
        profile: p,
        job: job,
        matching: 0.01
       )
      mj.save
      mj.calculate_matching
    end
  end

end
