class ProfilesController < ApplicationController
  layout "home_layout", only: [ :home ]
  skip_before_action :authenticate_user!, only: [:home, :create, :show, :find_match, :edit, :update, :test ]

  before_action :set_profile, only: [:edit, :update]
  skip_after_action :verify_policy_scoped, only: [:update]
  skip_after_action :verify_authorized, only: [:update]

  def home
    #TODO : si profil deja existant en session (faire un update plutôt qu'un update ?)

    # envoie au chat les valeurs d'initialisation
    initChat = {
        "options": {
          "preventAutoAppend": false,
          "preventAutoFocus": false
          },
        "tags": initial_tag
      }
    @json_init = initChat.to_json
    @profile = Profile.new()
    authorize @json_init
  end

  def create
    pparams = profile_raw_params
    @profile = Profile.new()
    # puts raw params in real params and create associated profile
    filter_params = @profile.filter_chat_info(pparams)
    @profile = Profile.new(filter_params)
    authorize @profile
    if @profile.save
      respond_to do |format|
          format.html {
            # flash[:notice] = "Un instant, je cherche des jobs qui correspondent à ton profil"
            # session[:session_info] = @profile.id
            redirect_to find_match_profile_path(@profile)
          }
          # format.js  { render :find_match }
      end
    else
      flash[:notice] = "Profile not created"
      render :home
    end
  end

  def find_match
    @profile = Profile.find(params[:id])
    @profile.remove_motivation_rankings
    @profile.remove_matched_jobs
    # add motivation rankings associated to profiles
    @profile = Profile.find(params[:id])
    @profile.add_motivation_rankings
    # create matched jobs associated to profile with appropriate matching percentage
    @profile = Profile.find(params[:id])
    @profile.create_matched_jobs
    # add a session id in cache for the profile
    session[:profile_id] = @profile.id
    # binding.pry
    # manage profile linking to current user if connected without any profile
    if current_user && ( current_user.profiles.nil? || current_user.profiles.length == 0)
      @profile.user = current_user
      @profile.save
      session[:profile_id] = nil
    end
    @profile = Profile.find(params[:id])
    authorize @profile
    sleep(5)
    redirect_to profile_matched_jobs_path(@profile)
  end

  def test
    # binding.pry
    @profile = Profile.all.last
    authorize @profile
  end

  # def show
  #   #TODO: pundit plus fin pour que seul le user / session puisse voir le profil
  #   @profile = Profile.find(params[:id])
  #   authorize @profile
  # end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile.update(profile_params)
    redirect_to profile_matched_jobs_path(@profile)
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit!
  end

  def profile_raw_params
    form_params = params.require(:profile).permit(:raw_chat_content)
    JSON.parse(form_params["raw_chat_content"])
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
