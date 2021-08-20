require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  let_it_be(:user) { create(:user) }
  let_it_be(:token) { JWT.encode({ user_id: user.id }, 'my_secret') }

  describe 'Inventory index' do
    context 'index action call success' do
      it 'when ajaxCall param is true' do
        params = { email: user.email, password: user.password }

        get :login, params: params, xhr: true

        expect(JSON.parse(response.body)['user']['id'] == user.id).to eq(true)
        expect(response).to have_http_status(:success)
      end

       it 'when email not present' do
        params = { email: '', password: user.password }

        get :login, params: params, xhr: true

        expect(JSON.parse(response.body)['message']).to eq('Email is Incorrect!')
      end

      it 'when password id incorrect' do
        params = { email: user.email, password: '' }

        get :login, params: params, xhr: true

        expect(JSON.parse(response.body)['message']).to eq('Password is Incorrect!')
      end
    end
  end
end
