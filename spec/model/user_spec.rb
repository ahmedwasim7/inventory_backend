require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:inventories).class_name('Inventory').with_foreign_key('creator_id') }
  end
end
