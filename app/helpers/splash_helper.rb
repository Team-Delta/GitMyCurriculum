# Helper for the user classes
module SplashHelper
  # defines the name of the resource
  def resource_name
    :user
  end

  # TODO WHAT DOES THIS DO?
  def resource
    @resource ||= User.new
  end

  # TODO WHAT DOES THIS DO?
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
