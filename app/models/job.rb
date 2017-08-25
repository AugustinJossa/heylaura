class Job < ApplicationRecord
  has_many :matched_jobs
  belongs_to :company

  JOB_CONTRACT_ARRAY = ['cdi','cdd','alternance','stage','temps partiel']
  JOB_REMOTE_ARRAY = ['oui','non']
  JOB_SALARY_ARRAY = [35000, 40000,45000,50000,60000,70000]
  JOB_TYPE_ARRAY = ['marketing','product','entreprise','bizdev','vente','logistique','achats', 'community management', 'rp', 'évènementiel']
  JOB_SUBTYPE_HASH = {
    'marketing' => ['produit', 'seo', 'sea', 'réseaux sociaux', 'opérationnel', 'stratégie'],
    'product' => ['tbd', 'tbd2'],
    'entreprise' => ['tbd', 'tbd2'],
    'bizdev' => ['tbd', 'tbd2'],
    'vente' => ['tbd', 'tbd2'],
    'logistique' => ['tbd', 'tbd2'],
    'achats' => ['tbd', 'tbd2'],
    'community management' => ['tbd', 'tbd2'],
    'rp' => ['tbd', 'tbd2'],
    'évènementiel' => ['tbd', 'tbd2']}
  JOB_SUBTYPE_ARRAY = ['produit', 'seo', 'sea', 'réseaux sociaux', 'opérationnel', 'stratégie']
  JOB_PROFILE_ARRAY =["créatif", "analytique", "esprit d'équipe", "leader" ]
end

