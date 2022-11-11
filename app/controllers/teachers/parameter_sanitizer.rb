class Teachers::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:teacher_name, :teacher_area])
  end
end