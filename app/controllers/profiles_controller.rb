class ProfilesController < ApplicationController
  layout "home_layout", only: [ :home ]
  skip_before_action :authenticate_user!, only: [:home, :create, :show, :find_match ]

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
    @profile = Profile.new()
    authorize @json_init
  end

  def create
    pparams = profile_params
    @profile = Profile.new()
    filter_params = @profile.filter_chat_info(pparams)
    @profile = Profile.new(filter_params)
    # binding.pry
    authorize @profile
    if @profile.save
      flash[:notice] = "Profile #{} has been created"
      # render :find_match
      redirect_to find_match_profile_path(@profile)
    else
      flash[:notice] = "Profile not created"
      render :home
    end
  end

  def find_match
    @profile = Profile.find(params[:id])
    authorize @profile
    # render :find_match
    sleep(5)
    redirect_to profile_path(@profile)
  end

  def show
    #TODO: pundit plus fin pour que seul le user / session puisse voir le profil
    @profile = Profile.find(params[:id])
    authorize @profile
  end


  private

  def profile_params
    JSON.parse(params.require(:profile))
    # params.require(:profile).permit(:company_type, :company_size, :company_industry)
  end

  def chat_init_text(id, question, placeholder=nil )
    {
      "tag": "input",
      "type": "text",
      "id": id,
      "cf-questions": question,
      "cf-input-placeholder": placeholder
    }
  end

  def chat_init_radio(id, question, radiotexts, placeholder = nil)
    {
      "tag": "fieldset",
      "type": "Radio buttons",
      "id": id,
      "cf-input-placeholder": placeholder || "Choisis ci-dessus",
      "cf-questions": question,
      "children": chat_radio_tags(radiotexts)
    }
  end

  def chat_radio_tags(texts)
    tags = texts.map do |text|
      {
        "tag": "input",
        "type": "radio",
        "cf-label": text
      }
    end
    return tags
  end

  def initial_tag
    [
      chat_init_text("first_name", "Salut&&Je m'appelle Laura et toi ?", "Ton prénom"),
      chat_init_radio("end", "Merci pour ta patience. C'est fini. && Tu veux voir les jobs qui te correspondent ?", ["Go"])
    ]
  end
end
