class Api::V1::AuthController < ApplicationController
  skip_before_action :require_login, only: :login

  before_action :set_user, :check_authentication, only: :login

  def login
    token = encode_token({ user_id: @user.id })

    render json: { user: @user, jwt: token }
  end

  private

  def set_user
    @user = User.find_by(email: params[:email])

    render json: { message: 'Email is Incorrect!' } if @user.blank?
  end

  def check_authentication
    render json: { message: 'Password is Incorrect!' } unless @user.authenticate(params[:password])
  end
end
