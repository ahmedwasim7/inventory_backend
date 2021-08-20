class InventorySerializer < ActiveModel::Serializer
  attributes :id, :barcode, :serial_no, :name, :description, :price, :purchase_date, :quantity, :created_by, :created_at

  def created_by
    object.creator.first_name + object.creator.last_name
  end
end
