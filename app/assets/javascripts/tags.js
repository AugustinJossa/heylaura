// tags management
const createCompanyTags = (types, industries, sizes) => {
  const tags = [
    chatRadio("go_company",
      "Bienvenue {previous-answer} && Je vais t'aider à trouver le job de tes rêves. && Il suffit de répondre à quelques questions simples et je te proposerai les jobs qui te correspondent le mieux. && Prêt à tenter l'expérience ?",
      ["Go"]),
    chatRadio("company_type",
      "Nous allons commencer par parler de ton entreprise idéale. && Dans quel type d'entreprise aimerais-tu travailler ?",
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
    chatRadio("go_profile",
      "Je vois bien le type de job qui t'intéresse. && Parlons un peu de toi maintenant.",
      ["Go"]),
    chatText("main_school",
      "De quelle école es-tu diplômé ?",
      "HEC"),
    chatText("main_school_graduation_year",
      "Cool. Et en quelle année es-tu sorti de {previous-answer} ?",
      "2016"),
    chatText("nb_years_experience",
      "Et combien d'années d'expérience professionnelle (stages compris) as-tu ?",
      "2")
  ];
  return tags;
};

const createAspirTags = () => {
  const tags = [
    chatRadio("go_aspir",
      "Debut aspirations",
      ["Go"])
  ];
  return tags;
};

const createJobTags = (profileCompanyType, jobTypes, profileJobType, profileJobSubTypes, jobRemotes, jobContracts, jobSalaries) => {
  const tags = [
    chatRadio("go_profile",
      `Parfait, nous avons fini la partie entreprise. && Simple non ? && Nous allons maintenant parler du job de tes rêves en ${profileCompanyType}`,
      ["Go"]),
    chatRadio("job_type",
      "Quel type de job te conviendrait ? ",
      jobTypes),
    chatRadio("job_subtype",
      `Et plus précisément en ${profileJobType} ?`,
      profileJobSubTypes),
    chatText("job_location", "Dans quelle ville aimerais tu travailler ?", "Paris"),
    chatRadio("job_remote",
      "Cool, j'adore {previous-answer} ! && Et aimerais-tu pouvoir faire du télétravail ?",
      jobRemotes),
    chatRadio("job_contract",
      "OK. Finissons maintenant cette partie par des considérations bassement matérielles. && Quel type de contrat cherches-tu en priorité ?",
      jobContracts),
    chatRadio("job_min_salary",
      "Compris. Et le salaire annuel minimum qui t'irait ?",
      jobSalaries)
  ];
  return tags;
};
