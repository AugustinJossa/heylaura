
# curl --silent https://www.welcometothejungle.co/companies?q=&hPP=30&idx=cms_companies_production&p=0&dFR%5Bcompany_size%5D%5B0%5D=Entre%2015%20et%2050%20salari%C3%A9s&dFR%5Bcompany_size%5D%5B1%5D=%3C%2015%20salari%C3%A9s&dFR%5Bcompany_size%5D%5B2%5D=Entre%2050%20et%20250%20salari%C3%A9s&dFR%5Boffices%5D%5B0%5D=Paris&is_v=1 > companies.html

require 'open-uri' # Open an url
# require 'nokogiri' # HTML ==> Nokogiri Document
require 'faker'



def parse_jobs_list(page_number)
  url = "https://azertyjobs.com/page/#{page_number}"
  base_url = "https://azertyjobs.com/"

  html_file = open(url)
  html_doc = Nokogiri::HTML(html_file)
  # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
  html_doc.search('.master-presentation').each do |job|
    parse_job(job)
    puts "one job parsed"
    sleep(2)
  end
end

def save_json
  filepath = "jobloadertest.json"
  File.open(filepath, 'wb') do |file|
    file.write(JobLoader.all.to_json)
  end
  puts "json saved"
  JobLoader.destroy_all
end


def parse_job(job_doc)
  base_url = "https://azertyjobs.com"

  bck_picture = job_doc.search(".joboverview-image-background").last.attribute('style').value # difficile a utiliser
  logo_url = job_doc.search('.var-background > img').first.attribute('src').value #OK

  job_pres = job_doc.search('.presentation-job-title').first
    job_title = job_pres.text #OK
    job_path = job_pres.search('a').first.attribute('href').value #OK

  company = job_doc.search('.company').first
    company_path = company.attribute('href').value #OK
    company_name = company.text #OK

  job_short_desc = job_doc.search('.company-description-short').first.text #OK

  job_cat = job_doc.search('.tags-jobs').first
    job_tags = job_cat.search(".tags").map do |tag| #OK
      tag.text
    end

  job_city = job_doc.search('.location').first.text #OK

  company = {cname: company_name, cpath: company_path, clogourl: logo_url }
  job = { title: job_title, path: job_path, tags: job_tags, city: job_city, shortdesc: job_short_desc }

  job_url = "https://azertyjobs.com#{job_path}"

  job_details = parse_job_page(job_url)

  jobloader_hash = job.merge(company).merge(job_details)
  puts jobloader_hash

  jobloader_save(jobloader_hash)

    # binding.pry
end

def jobloader_save(hash)
  jl = JobLoader.new(hash)
  # jl.remote_img_url = jl.imgurl
  # jl.remote_logo_url = jl.clogourl
  jl.save
end


def parse_job_page(job_url)
  html_file = open(job_url)
  html_doc = Nokogiri::HTML(html_file)
  job_doc = html_doc.search(".wrapper-content-job").first
  job_tags = job_doc.search(".wrapper-aside-job-page > ul").search("li > p").map do |tag|
    tag.text
  end

  job_desc = job_doc.search(".description-job")
    # job_img_url = job_desc.first.search('img').attribute('src').value #OK à sauver
    job_desc_html = job_desc.inner_html
    job_desc_text = job_desc.text

  job_profile = job_doc.search(".description-profile > div")
    job_profile_html = job_profile.inner_html
    job_profile_text = job_profile.text

  job_details = { detailtags: job_tags,
    deschtml: job_desc_html, desctext: job_desc_text,
    profilhtml: job_profile_html, profiltext: job_profile_text
  }

  return job_details
end
# ========================================== FIN CODE PARSER

def load_json
  filepath = "jobloadertest.json"
  serialized_jobs = File.read(filepath)
  jobs = JSON.parse(serialized_jobs)

  jobs.each do |job|
    job["id"] = nil
    job["created_at"] = nil
    job["updated_at"] = nil
    jl = JobLoader.new(job)
    jl.save
  end
  puts "json loaded"
end


def seed_candidates
  puts 'Creating 5 candidates'
  5.times do
    user = User.new(
      email: Faker::Internet.unique.email,
      password: '12345678',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      headline: Faker::Job.title,
      location: Faker::Address.city,
      positions: Faker::Job.field,
      )
    user.save
  end
end


def seed_company(jl)

  comp = Company.new(
    name: jl.cname,
    location: jl.city,
    location_lat: nil,
    location_lng: nil,
    company_type: COMPANY_TYPE_ARRAY.sample,
    industry: COMPANY_INDUSTRY_ARRAY.sample,
    size: COMPANY_SIZE_ARRAY.sample,
    description: jl.shortdesc,
    logo: jl.clogourl,
    picture: nil,
    user_id: nil,
    )

    url = ["https://static.pexels.com/photos/7096/people-woman-coffee-meeting.jpg", "https://static.pexels.com/photos/7369/startup-photos.jpg", "https://static.pexels.com/photos/7097/people-coffee-tea-meeting.jpg", "https://static.pexels.com/photos/40218/business-innovation-money-icon-40218.jpeg", "https://static.pexels.com/photos/7355/startup-photos.jpg", "https://static.pexels.com/photos/296878/pexels-photo-296878.jpeg", "https://static.pexels.com/photos/355988/pexels-photo-355988.jpeg", "https://static.pexels.com/photos/450271/pexels-photo-450271.jpeg", "https://static.pexels.com/photos/296886/pexels-photo-296886.jpeg"]
    comp.picture = url.sample
    comp.save!
    return comp

end


def seed_job(jl)
  5.times do
    job = Job.new(
      company_id: nil,
      title: jl.title,
      contract: JOB_CONTRACT_ARRAY.sample,
      remote: JOB_REMOTE_ARRAY.sample,
      salary: JOB_SALARY_ARRAY.sample,
      job_type: JOB_TYPE_ARRAY.sample,
      subtype: nil,
      description: jl.desctext,
      profile: JOB_PROFILE_ARRAY.sample,
      open: true
      )

      # first_id = Company.first.id
      # last_id = Company.last.id
      job.company = Company.find(jl.id)

    if job.job_type == "marketing"
      job.subtype = JOB_SUBTYPE_ARRAY.sample
    else
      job.subtype = nil
    end

    job.save!
  end
  puts "profile created"
end


def seed_profile


main_diploma_array = ["licence", "M1", "M2"]
main_school_array = ["HEC", "IESEG", "Dauphine", "Audencia", "Centrale", "le wagon"]
main_school_major_topic_array = ["marketing", "finance", "stratégie", "supplychain", "conseil"]
main_diploma_array = []
nb_years_experience_array = [1,2,3]
main_school_graduation_year_array = [2010,2011,2012,2013,2014]

  prof = Profile.new(
    user: nil,
    main_diploma: main_diploma_array.sample,
    main_school: main_school_array.sample,
    main_school_major_topic: main_school_major_topic_array.sample,
    main_school_graduation_year: main_school_graduation_year_array.sample,
    nb_years_experience: nb_years_experience_array.sample,
    company_type: COMPANY_TYPE_ARRAY.sample,
    company_industry: COMPANY_INDUSTRY_ARRAY.sample,
    company_size: COMPANY_SIZE_ARRAY.sample,
    job_type: JOB_TYPE_ARRAY.sample,
    job_subtype: nil,
    job_location: Faker::Address.city,
    job_remote: JOB_REMOTE_ARRAY.sample,
    job_contract: JOB_CONTRACT_ARRAY.sample,
    job_min_salary: JOB_SALARY_ARRAY.sample,
    )

    if prof.job_type == "marketing"
      prof.job_subtype = JOB_SUBTYPE_ARRAY.sample
    else
      prof.job_subtype = nil
    end

    prof.save!
    prof.user = User.find(prof.id)

    return prof

end



  def seed_elements
    JobLoader.all.each do |jl|
      seed_company(jl)
      seed_job(jl)
      seed_profile
    end
  end


def seed_new_data
  Company.destroy_all
  Job.destroy_all
  MatchedJob.destroy_all
  User.destroy_all
  RequiredSkill.destroy_all

  seed_candidates
  seed_elements


end

# def seed_jrs(job)
#   if rand < 0.5 # Deux chances sur trois d avoir des candidats
#     candidates_number = rand(1..4)
#     candidates = User.where(is_candidate: true).sample(candidates_number)
#     candidates.each do |candidate|
#       jr = JobRequest.new(
#         current_status: %w(pending refused accepted).sample,
#         job: job,
#         user: candidate,
#         message: Faker::Lorem.sentence
#         )
#       jr.save
#     end
#   end
# end

# parse_jobs_list(1)
# parse_jobs_list(2)
# parse_jobs_list(3)
# parse_jobs_list(4)
# save_json
load_json
seed_new_data
