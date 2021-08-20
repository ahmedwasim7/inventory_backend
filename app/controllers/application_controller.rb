class ApplicationController < ActionController::API
  before_action :require_login, except: :login

  def encode_token(payload)
    JWT.encode(payload, 'my_secret')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ').last

    begin
      JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      []
    end
  end

  def session_user
    decoded_hash = decoded_token

    return nil if decoded_hash&.empty? || decoded_hash.nil?

    @user = User.find_by(id: decoded_hash.first['user_id'])
  end

  def logged_in?
    !!session_user
  end

  def require_login
    render json: {message: 'Please Login'}, status: :unauthorized unless logged_in?
  end

  def current_user
    @user
  end
end
