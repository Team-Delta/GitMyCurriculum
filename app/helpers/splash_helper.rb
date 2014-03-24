# Helper for the user classes
module SplashHelper
  # defines the name of the resource
  def resource_name
    :user
  end

  # stores a user hash
  def resource
    @resource ||= User.new
  end

  # map the user hash
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
