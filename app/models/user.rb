class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:linkedin]

  # after_create :set_user_in_profile

	def self.find_for_linkedin_oauth(auth)
	  user_params = auth.slice(:provider, :uid)
	  user_params.merge! auth.info.slice(:email_address, :first_name, :last_name, :headline, :location, :positions, :public_profil_url)
	  # user_params[:linkedin_picture_url] = auth.info.image
	  user_params[:token] = auth.credentials.token
	  user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
	  user_params = user_params.to_h

	  user = User.find_by(provider: auth.provider, uid: auth.uid)
	  user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.

	  if user
	      user.update(user_params)
	  else
	    user = User.new(user_params)
	    user.password = Devise.friendly_token[0,20]  # Fake password for validation
	    user.save
	  end

	  return user
	end

  private

  # def set_user_in_profile
  #   # profile = Profile.find(cookies[:profile_id]) if cookies[:profile_id]
  #   profile = Profile.all.last
  #   profile.user = self
  #   profile.save
  # end

end
