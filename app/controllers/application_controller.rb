class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  def successful_json(message = "Succeeded.")
    render json: { message: message }, status: :ok
  end

  def created_json(message = "Created.")
    render json: { message: message }, status: :created
  end

  def accepted_json(message = "Request accepted.")
    render json: { message: message }, status: :accepted
  end

  def render_bad_request(e = nil)
    render_error(e.message, 400)
  end

  def model_error_json(active_model_errors, status = :unprocessable_entity)
    errors = transform_model_errors(active_model_errors)
    Rails.logger.error "model_error_json errors: #{errors}, status: #{status}"
    render json: { errors: errors }, status: status
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_name, :date_of_birth, :gender, :nationality, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :user_name, :date_of_birth, :gender, :nationality, :phone_number])
  end
end
