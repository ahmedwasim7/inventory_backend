class Inventory < ApplicationRecord
  belongs_to :creator, class_name: :User, foreign_key: :creator_id

  validates :barcode, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 50 }
  validates :serial_no, presence: true, numericality: true
  validates :purchase_date, presence: true
  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true

  before_create :create_barcode

  private

  def create_barcode
    id = Inventory.unscoped.last.blank? ? 1 : Inventory.unscoped.last.id.succ
    self.barcode = "A-#{Time.zone.today.strftime('%y')}-#{id.to_s.rjust(4, '0')}"
  end
end
