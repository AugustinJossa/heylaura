class MatchedJob < ApplicationRecord
  belongs_to :profile
  belongs_to :job

  def calculate_matching
    p = profile
    j = job
    c = job.company

    puts comp_match = calculate_company_matching(p, c)
    puts job_match = calculate_job_matching(p, j)
    puts location_match = calculate_location_matching(p, j, c)
    puts salary_match = calculate_salary_matching(p, j)

    motiv = p.motivation_rankings

    weights = {
      1 =>  0.4,
      2 => 0.3,
      3 => 0.15,
      4 => 0.05
    }
    final_match = 0.0
    motiv.each do |ranking|
      motiv_category = ranking.motivation_category.name
      weight = weights[ranking.position]
      match_coeff = case motiv_category
         when "Type d'entreprise" then comp_match
         when "Type de job" then job_match
         when "Localisation" then location_match
         when "Salaire et contrat" then salary_match
         else
          binding.pry
      end
      puts match_coeff
      puts weight
      final_match += match_coeff * weight
    end
    puts "match: #{final_match}"
    self.matching = final_match + 0.1
    self.save
  end

  private

  def calculate_company_matching(profile, company)
    match = 0
    match += 1 if profile.company_type == company.company_type
    match += 1 if profile.company_industry == company.industry
    match += 1 if profile.company_size == company.size
    match.fdiv(3)
  end

  def calculate_job_matching(profile, job)
    match = 0
    match += 1 if profile.job_type == job.job_type
    match += 1 if match == 1 && profile.job_subtype == job.subtype
    match.fdiv(2)
  end

  def calculate_location_matching(profile, job, company)
    match = 0
    match += 1 if profile.job_location.downcase.strip == company.location.downcase.strip
    match += 1 if profile.job_remote == job.remote
    match.fdiv(2)
  end

  def calculate_salary_matching(profile, job)
    match = 0
    match += 3 if profile.job_contract == job.contract
    match += 1 if profile.job_min_salary >= job.salary
    match +=1 if profile.nb_years_experience >= job.experience
    match.fdiv(5)
  end
end
