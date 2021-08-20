require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let_it_be(:user) { create(:user) }

  let_it_be(:inventory) do
    create(:inventory, creator: user)
  end

  describe 'associations' do
    it { should belong_to(:creator).class_name(:User).with_foreign_key(:creator_id) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:barcode).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:serial_no) }
    it { should validate_presence_of(:purchase_date) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity) }
  end
end
