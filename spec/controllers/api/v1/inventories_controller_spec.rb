require 'rails_helper'

RSpec.describe Api::V1::InventoriesController, type: :controller do
  let_it_be(:user) { create(:user) }
  let_it_be(:token) { JWT.encode({ user_id: user.id }, 'my_secret') }

  let_it_be(:inventory) do
    create(:inventory, creator: user)
  end

  describe 'Inventory index' do
    context 'All Inventories' do
      it 'when ajaxCall param is true' do
        request.headers.merge!(authorization: "Bearer #{token}")

        params = { page: 1, per_page: 25 }

        get :index, params: params, xhr: true

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['total']).to eq(1)
      end

      it 'when page not given' do
        request.headers.merge!(authorization: "Bearer #{token}")

        params = { per_page: 25 }

        get :index, params: params, xhr: true

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('page and per_page is missing in params!')
      end
    end

    context 'Create Inventory' do
      it 'when ajaxCall param is true' do
        request.headers.merge!(authorization: "Bearer #{token}")

        params = { inventory: attributes_for(:inventory) }

        post :create, params: params, xhr: true

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['id']).to be_present
      end

      it 'when ajaxCall param is false' do
        request.headers.merge!(authorization: '')

        params = { inventory: attributes_for(:inventory) }

        post :create, params: params, xhr: true

        expect(response).to have_http_status(:unauthorized)
      end

      it 'when ajaxCall param is false' do
        params = { inventory: attributes_for(:inventory) }

        post :create, params: params, xhr: true

        expect(response).to have_http_status(:unauthorized)
      end

      it 'when ajaxCall param is false' do
        allow_any_instance_of(Inventory).to receive(:save).and_return(false)

        request.headers.merge!(authorization: "Bearer #{token}")

        params = { inventory: attributes_for(:inventory) }

        post :create, params: params, xhr: true

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('Inventory Creation Failed!')
      end
    end

    context 'Update Inventory' do
      it 'when ajaxCall param is true' do
        allow_any_instance_of(Inventory).to receive(:update).and_return(false)

        request.headers.merge!(authorization: "Bearer #{token}")

        updated_inventory = attributes_for(:inventory, price: 200)

        params = { id: inventory.id, inventory: updated_inventory }

        patch :update, params: params, xhr: true

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('Inventory Updation Failed!')
      end

      it 'when ajaxCall param is false' do
        request.headers.merge!(authorization: "Bearer #{token}")

        updated_inventory = attributes_for(:inventory, price: 200)

        params = { id: inventory.id, inventory: updated_inventory }

        patch :update, params: params, xhr: true

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['price']).to eq(200)
      end
    end

    context 'Delete Inventory' do
      it 'when ajaxCall param is true' do
        request.headers.merge!(authorization: "Bearer #{token}")

        params = { id: inventory.id }

        delete :destroy, params: params, xhr: true

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['id']).to be_present
      end

      it 'when ajaxCall param is false' do
        allow_any_instance_of(Inventory).to receive(:destroy).and_return(false)

        request.headers.merge!(authorization: "Bearer #{token}")

        params = { id: inventory.id }

        delete :destroy, params: params, xhr: true

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('Inventory Deletion Failed!')
      end

      it 'when inventory not found' do
        request.headers.merge!(authorization: "Bearer #{token}")

        params = { id: '' }

        delete :destroy, params: params, xhr: true

        expect(JSON.parse(response.body)['message']).to eq('Inventory Not Found!')
      end
    end
  end
end
