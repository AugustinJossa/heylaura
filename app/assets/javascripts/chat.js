// functions to manage the DOM

const initHomePageDOM = () => {
  const startButton = document.getElementById("start-button");
  const bannerStart = document.getElementById("bstart");
  const bannerChat = document.getElementById("bchat");

  chatRestit = document.getElementById("chatrestit");
  perCent = document.getElementById("percent");
  entTag = document.getElementById("entreprise");
  jobTag = document.getElementById("job");
  profTag = document.getElementById("profil");
  aspiTag = document.getElementById("aspirations");

  startButton.addEventListener("click", (event) => {
    event.preventDefault;
    bannerStart.classList.add("hidden");
    bannerChat.classList.remove("hidden");
    initCf(jsonInit);
  });
  // const dispatcher = new cf.EventDispatcher();
};

// functions to create tags for questions

const chatText = (id, question, placeholder) => {
  return(
    [{
      'tag': 'input',
      'type': 'text',
      'id': id,
      'cf-questions': question,
      'cf-input-placeholder': placeholder || "Ta réponse"
    }]
  );
};

const chatRadioTags = (texts) => {
  const tags = texts.map((text) => {
    return(
      {
        "tag": "input",
        "type": "radio",
        "cf-label": text
      }
    );
  });
  return tags;
};

const chatRadio = (id, question, radioTexts, placeholder) => {
  return(
    [{
      "tag": "fieldset",
      "type": "Radio buttons",
      "cf-input-placeholder": placeholder || "Choisis ci-dessus", // TODO: sert a rien pour l instant
      "cf-questions": question,
      "children": chatRadioTags(radioTexts)
    }]
  );
};

// functions to manage the chat flow

const updateCompletion = (i) => {
  perCent.innerText = Math.round(i / totalLength * 100);
};

const runCompanyQuestionnaire = () => {
  entTag.classList.add("current-questions");
  cForm.addTags(companyTags[iComp], true);
  iComp = iComp + 1;
}

const runJobQuestionnaire = () => {
  jobTag.classList.add("current-questions");
  cForm.addTags(jobTags[iJob], true);
  iJob = iJob + 1;

}

const runProfileQuestionnaire = () => {
  profTag.classList.add("current-questions");
  cForm.addTags(profileTags[iProfile], true);
  iProfile = iProfile + 1;
}

const runAspirQuestionnaire = () => {
  aspiTag.classList.add("current-questions");
  cForm.addTags(aspirTags[iAspir], true);
  iAspir = iAspir + 1;

}

const callbackCfQuestion = (dto, success, error) => {
  // save value
  // TODO
  if (iComp < companyTags.length) {
    runCompanyQuestionnaire();
  } else {
    entTag.classList.remove("current-questions");
    if (iJob < jobTags.length) {
      runJobQuestionnaire();
    } else {
      jobTag.classList.remove("current-questions");
      if (iProfile < profileTags.length) {
        runProfileQuestionnaire();
      } else {
        profTag.classList.remove("current-questions");
        if (iAspir < aspirTags.length) {
          runAspirQuestionnaire();
        } else {
          aspiTag.classList.remove("current-questions");
        }
      }
    }
  }
  i = i +1;
  updateCompletion(i);
  success();
};

const endCf = () => {
    console.log("end");
    cForm.addRobotChatResponse("THE END");
};

const initCf = (jsonInit) => {
  jsonInit.options.submitCallback = endCf.bind(window);
  jsonInit.options.flowStepCallback = callbackCfQuestion.bind(window);
  cForm = window.cf.ConversationalForm.startTheConversation(jsonInit);
  chatRestit.appendChild(cForm.el);
};

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
    chatRadio("company_sizes",
      "C'est noté. Et quel serait la taille idéale de la boîte de tes rêves ?",
      sizes),
    chatRadio("go_entreprise",
      "Parfait, nous avons fini la partie entreprise. && Simple non ? && Nous allons maintenant parler du job de tes rêves en XXX.",
      ["Go"])
  ];
  return tags;
};

const createJobTags = () => {
  const tags = [
    chatRadio("go_job",
      "Debut job",
      ["Go"])
  ];
  return tags;
};

const createProfileTags = () => {
  const tags = [
    chatRadio("go_profile",
      "Debut profile",
      ["Go"])
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


