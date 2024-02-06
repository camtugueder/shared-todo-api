# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friend, type: :model do

  describe 'associations' do
    it { should belong_to(:group) }

    # Assuming Friend has_many :tasks
    it { should have_many(:tasks).dependent(:destroy) }

    # Add more association tests if there are other associations
  end

  describe 'validations' do
    let(:group) { create(:group) } # Use let to define common setup

    it 'creates a valid friend' do
      friend = build(:friend, group: group)
      expect(friend).to be_valid
      expect(friend.errors).to be_empty
    end

    describe 'name' do
      context 'when name is nil' do
        it 'is not valid' do
          friend = build(:friend, name: nil, group: group)
          expect(friend).not_to be_valid
          expect(friend.errors.full_messages).to include("Name can't be blank")
        end
      end
    end

    describe 'group association' do
      context 'when group is nil' do
        it 'is not valid' do
          friend = build(:friend, group: nil)
          expect(friend).not_to be_valid
          expect(friend.errors.full_messages).to include("Group must exist")
        end
      end
    end

    describe 'color' do
      context 'when color is empty' do
        it 'is not valid' do
          friend = build(:friend, color: '', group: group)
          expect(friend).not_to be_valid
          expect(friend.errors.full_messages).to include("Color can't be blank")
        end
      end

      context 'when color is a valid name' do
        it 'is valid' do
          valid_color_names = %w[red green blue yellowgreen aqua]
          valid_color_names.each do |color|
            friend = build(:friend, color: color, group: group)
            expect(friend).to be_valid
          end
        end
      end

      context 'when color is a valid hex RGB code' do
        it 'is valid' do
          valid_hex_colors = %w[#FF5733 #BADA55 #000000 #ffffff #123ABC #123abc]
          valid_hex_colors.each do |color|
            friend = build(:friend, color: color, group: group)
            expect(friend).to be_valid
          end
        end
      end

      context 'when color is an invalid name' do
        it 'is not valid' do
          friend = build(:friend, color: 'invalidcolorname', group: group)
          expect(friend).not_to be_valid
          expect(friend.errors.full_messages).to include("Color must be a valid color name or a valid hex RGB color code")
        end
      end

      context 'when color is an invalid hex RGB code' do
        it 'is not valid' do
          invalid_hex_colors = ['#12345G', '#1234', '123ABZ']
          invalid_hex_colors.each do |color|
            friend = build(:friend, color: color, group: group)
            expect(friend).not_to be_valid
            expect(friend.errors.full_messages).to include("Color must be a valid color name or a valid hex RGB color code")
          end
        end
      end
    end
  end

end
