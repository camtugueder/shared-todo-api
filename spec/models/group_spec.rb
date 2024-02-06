# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it { should have_many(:friends).dependent(:destroy) }
  end
  describe 'validations' do
    it "is valid with valid attributes" do
      group = create(:group, name: "Group Name")
      expect(group).to be_valid
    end

    it "is not valid without a name" do
      group = build(:group, name: nil)
      expect(group).not_to be_valid
    end

    it "is not valid with an empty name" do
      group = build(:group, name: '')
      expect(group).not_to be_valid
    end
  end

end
