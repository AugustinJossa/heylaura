
# curl --silent https://www.welcometothejungle.co/companies?q=&hPP=30&idx=cms_companies_production&p=0&dFR%5Bcompany_size%5D%5B0%5D=Entre%2015%20et%2050%20salari%C3%A9s&dFR%5Bcompany_size%5D%5B1%5D=%3C%2015%20salari%C3%A9s&dFR%5Bcompany_size%5D%5B2%5D=Entre%2050%20et%20250%20salari%C3%A9s&dFR%5Boffices%5D%5B0%5D=Paris&is_v=1 > companies.html

require 'open-uri' # Open an url
# require 'nokogiri' # HTML ==> Nokogiri Document
require 'faker'
require 'csv'
require 'pry-byebug'

def destroy_data
  puts "Destrying data..."
  JobLoader.destroy_all
  MatchedJob.destroy_all
  MotivationRanking.destroy_all
  Job.destroy_all
  Company.destroy_all
  # RequiredSkill.destroy_all
  MotivationCategory.destroy_all
  Profile.destroy_all
  User.destroy_all
  puts "Data destroyed..."
end

def load_json
  filepath = "jobloaderdone.json"
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

def save_json
  filepath = "jobloaderdone.json"
  File.open(filepath, 'wb') do |file|
    file.write(JobLoader.all.to_json)
  end
  puts "json saved"
  JobLoader.destroy_all
end

def save_csv
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  filepath = 'jobloader.csv'
  CSV.open(filepath, 'wb', csv_options) do |csv|
    headers = JobLoader.attribute_names.reject do |attrib|
      ["shortdesc", "deschtml", "desctext", "profilhtml", "profiltext"].include?(attrib)
    end
    csv << headers
    JobLoader.all.each do |jl|
      values = []
      jl.attributes.each do |attrib|
        values << attrib[1] if headers.include?(attrib[0])
      end
      csv << values
    end
  end
end

def load_csv
  csv_options_load = { headers: :first_row, header_converters: :symbol, col_sep: ';', encoding: 'iso-8859-1:utf-8' }
  CSV.foreach('jobloaderdone.csv', csv_options_load) do |row|
    row[:id]    = row[:id].to_i          # Convert column to Fixnum
    jl = JobLoader.find(row[:id])
    puts row
    load_hash = {}
    row.each do |el|
      load_hash[el[0]] = el[1] if el[0]
    end
    # binding.pry
    jl.update(load_hash)
    jl.save
    puts "1 jl loaded"
  end
end

# destroy_data
# load_json

# # save_csv
# load_csv

save_json
destroy_data
load_json










# def seed_candidates
#   5.times do
#     user = User.new(
#       email: Faker::Internet.unique.email,
#       password: '12345678',
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       headline: Faker::Job.title,
#       location: Faker::Address.city,
#       positions: Faker::Job.field,
#       )
#     user.save
#   end
# end


# def seed_company(jl)
#   company = Company.find_by(name: jl.cname)
#     # binding.pry
#   unless company
#     comp = Company.new(
#       name: jl.cname,
#       location: jl.city,
#       location_lat: nil,
#       location_lng: nil,
#       company_type: Company::COMPANY_TYPE_ARRAY.sample,
#       industry: Company::COMPANY_INDUSTRY_ARRAY.sample,
#       size: Company::COMPANY_SIZE_ARRAY.sample,
#       description: jl.shortdesc,
#       logo: jl.clogourl,
#       picture: nil,
#       user_id: nil,
#       )
#       url = ["https://static.pexels.com/photos/7096/people-woman-coffee-meeting.jpg", "https://static.pexels.com/photos/7369/startup-photos.jpg", "https://static.pexels.com/photos/7097/people-coffee-tea-meeting.jpg", "https://static.pexels.com/photos/40218/business-innovation-money-icon-40218.jpeg", "https://static.pexels.com/photos/7355/startup-photos.jpg", "https://static.pexels.com/photos/355988/pexels-photo-355988.jpeg", "https://static.pexels.com/photos/450271/pexels-photo-450271.jpeg", "https://static.pexels.com/photos/296886/pexels-photo-296886.jpeg"]
#       heavy_url_photos = ["https://static.pexels.com/photos/296878/pexels-photo-296878.jpeg"]
#       comp.remote_logo_url = jl.clogourl
#       comp.remote_picture_url = url.sample
#       comp.save!
#       return comp
#   end
# end


# def seed_job(jl)
#   # 5.times do
#     company = Company.find_by(name: jl.cname)
#     job = Job.new(
#       company: company,
#       title: jl.title,
#       contract: Job::JOB_CONTRACT_ARRAY.sample,
#       remote: Job::JOB_REMOTE_ARRAY.sample,
#       salary: Job::JOB_SALARY_ARRAY.sample,
#       job_type: Job::JOB_TYPE_ARRAY.sample,
#       subtype: nil,
#       description: jl.desctext,
#       profile: Job::JOB_PROFILE_ARRAY.sample,
#       open: true
#       )

#       # first_id = Company.first.id
#       # last_id = Company.last.id
#       # job.company = Company.find(jl.id)

#     if job.job_type == "marketing"
#       job.subtype = Job::JOB_SUBTYPE_ARRAY.sample
#     else
#       job.subtype = nil
#     end

#     job.save!
#   # end

# end


# def seed_profile

# main_diploma_array = ["licence", "M1", "M2"]
# main_school_array = ["HEC", "IESEG", "Dauphine", "Audencia", "Centrale", "le wagon"]
# main_school_major_topic_array = ["marketing", "finance", "stratégie", "supplychain", "conseil"]
# main_diploma_array = []
# nb_years_experience_array = [1,2,3]
# main_school_graduation_year_array = [2010,2011,2012,2013,2014]

#   User.all.each do |user|
#     prof = Profile.new(
#       user: user,
#       main_diploma: main_diploma_array.sample,
#       main_school: main_school_array.sample,
#       main_school_major_topic: main_school_major_topic_array.sample,
#       main_school_graduation_year: main_school_graduation_year_array.sample,
#       nb_years_experience: nb_years_experience_array.sample,
#       company_type: Company::COMPANY_TYPE_ARRAY.sample,
#       company_industry: Company::COMPANY_INDUSTRY_ARRAY.sample,
#       company_size: Company::COMPANY_SIZE_ARRAY.sample,
#       job_type: Job::JOB_TYPE_ARRAY.sample,
#       job_subtype: nil,
#       job_location: ["Paris", "Bordeaux", "Paris", "Rennes", "Strasbourg", "Paris", "Vincennes", "Marseille"].sample,
#       job_remote: Job::JOB_REMOTE_ARRAY.sample,
#       job_contract: Job::JOB_CONTRACT_ARRAY.sample,
#       job_min_salary: Job::JOB_SALARY_ARRAY.sample,
#       )

#       if prof.job_type == "marketing"
#         prof.job_subtype = Job::JOB_SUBTYPE_ARRAY.sample
#       else
#         prof.job_subtype = nil
#       end
#     prof.save!

#   end

# end



#   def seed_matched_jobs

#     status_array = ["Bookmarked", "Pending", "Accepted", "Rejected"]
#     message_array = ["Je suis extremement motive", "Je suis tres interesse par votre entreprise", "J'adore votre produit", "Je suis desespere, embauchez-moi"]
#     number_of_jobs = Job.count
#     number_of_profiles = Profile.count
#     profiles = Profile.all
#     jobs = Job.all


#       profiles.each do |p|
#         jobs.each do |j|

#           proba = 1.fdiv(rand(1..5))

#           m_j = MatchedJob.new(
#           profile: p,
#           job: j,
#           matching: proba,
#           status: status_array.sample,
#           message: message_array.sample
#           )
#           m_j.save!

#         end
#       end

#   end

#   def seed_elements
#     JobLoader.all.each do |jl|
#       seed_company(jl)
#       seed_job(jl)
#     end
#   end


# def seed_new_data
#   seed_candidates
#   puts "#{User.count} users created"
#   seed_elements
#   puts "#{Company.count} companies created"
#   # puts "#{Job.count} jobs created"
#   seed_profile
#   puts "#{Profile.count} profiles created"
#   seed_matched_jobs
#   puts "#{MatchedJob.count} matched jobs created"


# end

# def seed_motivation_categories
#   MotivationCategory.destroy_all
#   categories = ["Type d'entreprise", "Type de job", "Localisation", "Salaire et contrat"]
#   categories.each do |category|
#     MotivationCategory.create(name: category)
#     puts "motivation category created"
#   end
# end

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


