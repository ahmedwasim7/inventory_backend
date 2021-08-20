class User < ApplicationRecord
  has_secure_password

  has_many :inventories, class_name: :Inventory, foreign_key: :creator_id
end
