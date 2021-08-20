class Api::V1::InventoriesController < ApplicationController
  before_action :set_inventories, only: :index
  before_action :set_inventory, only: [:update, :destroy]

  def index
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(@inventories),
      total: @inventories.count
    }
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      render json: @inventory
    else
      render json: { message: 'Inventory Creation Failed!' }, status: :bad_request
    end
  end

  def update
    if @inventory.update(inventory_params)
      render json: @inventory
    else
      render json: { message: 'Inventory Updation Failed!' }, status: :bad_request
    end
  end

  def destroy
    if @inventory.destroy
      render json: @inventory
    else
      render json: { message: 'Inventory Deletion Failed!' }, status: :bad_request
    end
  end

  private

  def set_inventory
    @inventory = Inventory.find_by(id: params[:id])

    render json: { message: 'Inventory Not Found!' } unless @inventory.present?
  end

  def inventory_params
    params.require(:inventory).permit(:id, :name, :description, :serial_no, :price, :purchase_date, :quantity).tap do |additional_params|
      additional_params[:creator_id] = current_user.id
    end
  end

  def set_inventories
    render json: { message: 'page and per_page is missing in params!' } if params[:page].blank? || params[:per_page].blank?

    @inventories = Inventory.paginate({ page: params[:page], per_page: params[:per_page] })
  end
end
