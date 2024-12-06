require 'jwt'

class ApplicationController < ActionController::API
  before_action :authenticate_request, except: [:register]
  
  private
  # def authenticate_request
  #   header = request.headers['Authorization']
  #   if header
  #     # Remove any potential whitespace, line breaks, or non-printable characters
  #     header = header.strip.gsub(/\s+/, ' ')
      
  #     # Extract the token part after "Bearer "
  #     token = header.split(' ').last
    
  #     begin
  #       decoded = JWT.decode(header, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })[0]
  #       @current_user = User.find(decoded['user_id'])
  #     rescue ActiveRecord::RecordNotFound, JWT::DecodeError
  #       render json: { error: 'Unauthorized' }, status: :unauthorized
  #     end
  #   else
  #     render json: { error: 'Authorization header missing' }, status: :unauthorized
  #   end
  # end

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })
      @current_user = User.find(decoded[0]['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end