JOB_CONTRACT_ARRAY = ['cdi','cdd','alternance','stage','temps partiel']
JOB_REMOTE_ARRAY = ['yes','no']
JOB_SALARY_ARRAY = [35000, 40000,45000,50000,60000,70000]
JOB_TYPE_ARRAY = ['marketing','product','entreprise','bizdev','vente','logistique','achats', 'community management', 'rp', 'évènementiel']
JOB_SUBTYPE_ARRAY = ['produit', 'seo', 'sea', 'réseaux sociaux', 'opérationnel', 'stratégie']
JOB_PROFILE_ARRAY =["créatif", "analytique", "esprit d'équipe", "leader" ]


class Job < ApplicationRecord
  has_many :matched_jobs
  belongs_to :company
end
