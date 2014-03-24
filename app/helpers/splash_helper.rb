# Helper for the user classes
module SplashHelper
  # defines the name of the resource
  def resource_name
    :user
  end

  # TODO: what does this do?
  def resource
    @resource ||= User.new
  end

  # TODO: what does this do?
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
