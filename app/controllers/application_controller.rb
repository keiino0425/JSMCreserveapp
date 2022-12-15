class ApplicationController < ActionController::Base
  
  protected
  def devise_parameter_sanitizer
    if resource_class == User then
      Users::ParameterSanitizer.new(User, :user, params)
    elsif resource_class == Teacher
      Teachers::ParameterSanitizer.new(Teacher, :teacher, params)
    else
      super
    end
  end
end
