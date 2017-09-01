module ConstantsHelper

  def company_types
    Company::COMPANY_TYPE_ARRAY
  end

  def company_industries
    Company::COMPANY_INDUSTRY_ARRAY
  end

  def company_sizes
    Company::COMPANY_SIZE_ARRAY
  end

  def job_contracts
    Job::JOB_CONTRACT_ARRAY
  end

  def job_remotes
    Job::JOB_REMOTE_ARRAY
  end

  def job_salaries
    Job::JOB_SALARY_ARRAY
  end

  def job_types
    Job::JOB_TYPE_ARRAY
  end

  def job_subtypes(type = nil)
    type ? Job::JOB_SUBTYPE_HASH[type] : Job::JOB_SUBTYPE_HASH
  end

  def job_subtypes_json
    job_subtypes.to_json
  end

  def job_profiles
    Job::JOB_PROFILE
  end

  def motivation_categories
    MotivationCategory.all.map { |motiv_cat| motiv_cat.name }
  end

  def formatted_description(jobdesc)
    jd = jobdesc.delete '***'
    jd.html_safe
  end

  # def skills
  #   Skills.all.map { |skill| skill.name }
  # end
end
