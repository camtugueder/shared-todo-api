class Group < ApplicationRecord

  has_many :friends, dependent: :destroy

  validates :name, presence: true
end
