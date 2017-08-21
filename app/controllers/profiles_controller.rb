class ProfilesController < ApplicationController
  layout "home_layout", only: [ :home ]
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end
end
