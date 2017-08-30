// tags management
const createCompanyTags = (types, industries, sizes) => {
  const tags = [
    chatRadio("go_company",
      "Bienvenue {previous-answer}. Je vais t'aider à trouver le job de tes rêves. Il suffit de répondre à quelques questions simples et je te proposerai les jobs qui te correspondent le mieux. && Prêt à tenter l'expérience ?",
      ["Go"]),
    chatRadio("company_type",
      "Nous allons commencer par parler de ton entreprise idéale. Dans quel type d'entreprise aimerais-tu travailler ?",
      types),
    chatRadio("company_industry",
      "Parfait. Et dans quel secteur ?",
      industries),
    chatRadio("company_size",
      "C'est noté. Et quel serait la taille idéale de la boîte de tes rêves ?",
      sizes)
  ];
  return tags;
};

const createProfileTags = () => {
  const tags = [
    chatText("main_school",
      "Je vois bien le type de job qui t'intéresse. Parlons un peu de toi maintenant. De quelle école es-tu diplômé ?",
      "HEC"),
    chatText("nb_years_experience",
      "Et combien d'années d'expérience professionnelle (stages compris) as-tu ?",
      "2")
  ];
  return tags;
};

const createAspirTags = () => {
  const tags = [
    chatRadio("go_aspir",
      "Presque fini ! Il nous reste juste à parcourir tes aspirations professionnelles. && Prêt?",
      ["Go"]) ,
    chatRadio("motivLastCat",
      "Je vais te demander de classer les critères ci-dessous du plus important au moins important.&& Quel est pour toi le critère le plus important parmi les critères ci-dessous?",
      motivationCategories)
  ];
  return tags;
};

const createJobTags = (profileCompanyType, jobTypes, profileJobType, profileJobSubTypes, jobRemotes, jobContracts, jobSalaries) => {
  const tags = [
    chatRadio("job_type",
      `Parfait, nous avons fini la partie entreprise. Simple non ? && Nous allons maintenant parler du job de tes rêves en ${profileCompanyType}. Quel type de job te conviendrait ? `,
      jobTypes),
    chatRadio("job_subtype",
      `Et plus précisément en ${profileJobType} ?`,
      profileJobSubTypes),
    chatText("job_location", "Dans quelle ville aimerais tu travailler ?", "Paris"),
    chatRadio("job_remote",
      "Cool, j'adore {previous-answer} ! Et aimerais-tu pouvoir faire du télétravail ?",
      jobRemotes),
    chatRadio("job_contract",
      "OK. Finissons maintenant cette partie par des considérations bassement matérielles. Quel type de contrat cherches-tu en priorité ?",
      jobContracts),
    chatRadio("job_min_salary",
      "Compris. Et le salaire annuel minimum qui t'irait ?",
      jobSalaries)
  ];
  return tags;
};
