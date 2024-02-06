class Friend < ApplicationRecord
  include ColorValidatable

  belongs_to :group
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :group_id, presence: true
end
