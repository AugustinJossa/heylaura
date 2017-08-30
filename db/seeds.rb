
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


# ===================== CREATE DATA IN REAL TABLES

def seed_company(jl)
  company = Company.find_by(name: jl.cname)
    # binding.pry
  unless company
    comp = Company.new(
      name: jl.cname,
      location: jl.jlocation,
      location_lat: nil,
      location_lng: nil,
      company_type: jl.ctype,
      industry: jl.cindustry,
      size: jl.csize,
      description: jl.shortdesc,
      logo: jl.clogourl,
      picture: nil,
      user_id: nil,
      )
    url = ["https://static.pexels.com/photos/7096/people-woman-coffee-meeting.jpg", "https://static.pexels.com/photos/7369/startup-photos.jpg", "https://static.pexels.com/photos/7097/people-coffee-tea-meeting.jpg", "https://static.pexels.com/photos/40218/business-innovation-money-icon-40218.jpeg", "https://static.pexels.com/photos/7355/startup-photos.jpg", "https://static.pexels.com/photos/355988/pexels-photo-355988.jpeg", "https://static.pexels.com/photos/450271/pexels-photo-450271.jpeg", "https://static.pexels.com/photos/296886/pexels-photo-296886.jpeg"]
    heavy_url_photos = ["https://static.pexels.com/photos/296878/pexels-photo-296878.jpeg"]
    comp.remote_logo_url = jl.clogourl if jl.clogourl && jl.clogourl.length > 0
    comp.remote_picture_url = url.sample
    comp.save
    puts "one company saved"
    return comp
  end
end


def seed_job(jl)
  company = Company.find_by(name: jl.cname)
  job = Job.new(
    company: company,
    title: jl.title,
    contract: jl.jcontract,
    remote: jl.jremote,
    salary: jl.jsalary,
    job_type: jl.jtype,
    subtype: jl.jsubtype,
    description: jl.desctext,
    profile: Job::JOB_PROFILE_ARRAY.sample,
    experience: jl.jexperience,
    open: true
    )

  job.save!
  puts "one job saved"
end


def seed_jobloader
  JobLoader.all.each do |jl|
    seed_company(jl)
    seed_job(jl)
  end
end

def seed_motivation_categories
  MotivationCategory.destroy_all
  categories = ["Type d'entreprise", "Type de job", "Localisation", "Salaire et contrat"]
  categories.each do |category|
    MotivationCategory.create(name: category)
    puts "motivation category created"
  end
end


destroy_data
load_json
seed_motivation_categories
seed_jobloader

