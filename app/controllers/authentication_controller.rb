class AuthenticationController < ApplicationController

  skip_before_action :authenticate_request, only: [:register, :login, :logout]

  def register
    user = User.new(user_params)
    
    if user.save
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
  
  def logout
    render json: { message: 'Logged out successfully' }, status: :ok
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def encode_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256') 
  end
end