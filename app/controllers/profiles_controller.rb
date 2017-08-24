class ProfilesController < ApplicationController
  layout "home_layout", only: [ :home ]
  skip_before_action :authenticate_user!, only: [:home, :create, :show ]

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
    binding.pry
    authorize @profile
    if @profile.save
      flash[:notice] = "Profile #{} has been created"
      redirect_to profile_path(@profile)
    else
      flash[:notice] = "Profile not created"
      render :home
    end
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

  def initial_tag
    [ chat_init_text("first_name", "Salut&&Je m'appelle Laura et toi ?", "Ton prénom"),
    chat_init_text("end", "Merci", "end") ]
  end

  end













end
