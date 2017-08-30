class Job < ApplicationRecord
  has_many :matched_jobs
  belongs_to :company

  JOB_CONTRACT_ARRAY = ['cdi','cdd','stage']
  JOB_REMOTE_ARRAY = ['oui','non']
  JOB_SALARY_ARRAY = [35000, 40000,45000,50000,60000,70000]
  JOB_TYPE_ARRAY = ['Marketing & communication','Bizdev / sales','IT & dev','Autre']
  JOB_SUBTYPE_HASH = {
    'Marketing & communication' => ['communication','produit', 'seo/sea', 'réseaux sociaux', 'opérationnel', 'stratégie','ux'],
    'Bizdev / sales' => ['tbd', 'tbd2'],
    'IT & dev' => ['tbd', 'tbd2'],
    'Autre' => ['tbd', 'tbd2']}
  JOB_SUBTYPE_ARRAY = ['communication','produit', 'seo/sea', 'réseaux sociaux', 'opérationnel', 'stratégie','ux']
  JOB_PROFILE_ARRAY =["créatif", "analytique", "esprit d'équipe", "leader" ]
end

