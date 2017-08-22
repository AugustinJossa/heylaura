class ProfilesController < ApplicationController
  layout "home_layout", only: [ :home, :test ]
  skip_before_action :authenticate_user!, only: [:home, :test ]

  def home
  end

  def test
    file = File.join(Rails.root, 'app', 'controllers', 'files', 'formless.json')
    serialized_json = File.read(file)
    # raise
    json_object = JSON.parse(serialized_json)
    @json_file = json_object




  end
end
