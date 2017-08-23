class Skill < ApplicationRecord
	has_many :profile_skills
	has_many :required_skills
end
