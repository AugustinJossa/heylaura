class ProfilesController < ApplicationController
  layout "home_layout", only: [ :home ]
  skip_before_action :authenticate_user!, only: [:home ]

  def home
    #TODO : si profil deja existant en session

    # envoie au chat les valeurs d'initialisation
    initChat = {
        "options": {
          "preventAutoAppend": true,
          "preventAutoFocus": false
        },
        "tags": initial_tag
      }
    @json_init = initChat.to_json
    authorize @json_init
  end

  def test
  end

  private

  def chat_init_text(id, question, placeholder=nil )
    {
      "tag": "input",
      "type": "text",
      "id": id,
      "cf-questions": question,
      "cf-input-placeholder": placeholder
    }
  end

  def initial_tag
    [ chat_init_text("first_name", "Salut&&Je m'appelle Laura et toi ?", "Ton prénom"),
    chat_init_text("end", "Merci", "end") ]
  end

end
