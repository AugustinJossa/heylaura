// functions to manage the DOM

const initHomePageDOM = () => {
  const startButton = document.getElementById("start-button");
  const bannerStart = document.getElementById("bstart");
  const bannerChat = document.getElementById("bchat");

  chatRestit = document.getElementById("chatrestit");
  // perCent = document.getElementById("percent");
  entTag = document.getElementById("entreprise");
  jobTag = document.getElementById("job");
  profTag = document.getElementById("profil");
  aspiTag = document.getElementById("aspirations");
  profileForm = document.getElementById("chat-form");
  rawChatContent = document.getElementById("profile_raw_chat_content");
  chatEnd = document.getElementById("chatend")

  startButton.addEventListener("click", (event) => {
    event.preventDefault;
    // bannerStart.classList.add("hidden");
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
      "id": id,
      "cf-input-placeholder": placeholder || "Choisis ci-dessus", // TODO: sert a rien pour l instant
      "cf-questions": question,
      "children": chatRadioTags(radioTexts)
    }]
  );
};

// functions to manage the chat flow

const updateCompletion = (i) => {
  completionBar.currentpercent = Math.round(i * 100 / totalLength);
};

const runCompanyQuestionnaire = () => {
  entTag.classList.add("current-questions");
  cForm.addTags(companyTags[iComp], true);
  iComp = iComp + 1;
}

const runJobQuestionnaire = () => {
  if (iJob === 0) {
    jobTags = createJobTags(currentProfile.company_type, jobTypes, "Tout", jobSubTypes["Marketing & communication"], jobRemotes, jobContracts, jobSalaries);
  }
  if (iJob === 1) { // update with selectedJobType
    currentJobType = currentProfile.job_type;
    jobTags = createJobTags(currentProfile.company_type, jobTypes, currentJobType, jobSubTypes[currentJobType], jobRemotes, jobContracts, jobSalaries);
  }
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
  debugger;
  if (iAspir < aspirTags.length) {
    cForm.addTags(aspirTags[iAspir], true);
  } else {
    if (iAspir === aspirTags.length) {
      currentProfile["motivationCategories"] = [];
    }
    currentProfile["motivationCategories"][iAspir - aspirTags.length] = currentProfile["motivLastCat"];
    currentCategories = currentCategories.filter(category => category != currentProfile["motivLastCat"]);
    const currentTags = chatRadio("motivLastCat",
      "Et ensuite ? || Et puis ? || Très bien, et le suivant ?",
      currentCategories);
    cForm.addTags(currentTags, true);
  }
  iAspir = iAspir + 1;

}

const manageQuestionnaire = () => {
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
        if (iAspir < aspirTags.length + motivationCategories.length - 1) {
          runAspirQuestionnaire();
        } else {
          aspiTag.classList.remove("current-questions");
        }
      }
    }
  }
}

const callbackCfQuestion = (dto, success, error) => {
  currentProfile[dto.tag.id] = dto.text;
  if (i === -1) {
    console.log("test")
  } else {
    manageQuestionnaire();
    i = i +1;
    updateCompletion(i);
  }
  success();
};

const endChat = (normal) => {
  window.ConversationalForm.remove();
  chatEnd.classList.remove("hidden");
  if (normal === true) {
    currentProfile["session_info"] = sessionInfo;
    currentProfile["i"] = i;
    currentProfile["icomp"] = iComp;
    currentProfile["ijob"] = iJob;
    currentProfile["iprofile"] = iProfile;
    currentProfile["iaspir"] = iAspir;
    rawChatContent.value = JSON.stringify(currentProfile);
    // TO DO: mettre une div specifique pour la recherche de profil a la place du chat
    profileForm.submit();
  }
  // TO DO: gerer la fin impromptue du chat
}

const endCf = () => {
    endChat(true);
};

const initCf = (jsonInit) => {
  jsonInit.options.submitCallback = endCf.bind(window);
  jsonInit.options.flowStepCallback = callbackCfQuestion.bind(window);
  jsonInit.options.robotImage = robotImgUrl;
  jsonInit.options.userImage = userImgUrl;
  // jsonInit.options.userInterfaceOptions.robot.robotResponseTime = "0";
  // jsonInit.options.userInterfaceOptions = {
  //   controlElementsInAnimationDelay: 250,
  //   robot: {
  //     robotResponseTime: 5000,
  //     chainedResponseTime: 5000
  //   },
  //   user: {
  //     showThinking: false,
  //     showThumb: false
  //   }
  // };
  cForm = window.cf.ConversationalForm.startTheConversation(jsonInit);
  chatRestit.appendChild(cForm.el);
};
