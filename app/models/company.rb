COMPANY_TYPE_ARRAY = ['startup','agence', 'tpe', 'pme', 'grande entreprise']
COMPANY_INDUSTRY_ARRAY = ['santé', 'tech', 'rh', 'industrie', 'automobile', 'juridique', 'finance', 'conseil']
COMPANY_SIZE_ARRAY = ['< 10 employés', '10-19 employés', '20-49 employés', '50-200 employés', '> 200 employés']

class Company < ApplicationRecord
  has_many :jobs
  has_many :matched_jobs, through: :jobs
end
