class FriendSerializer < ActiveModel::Serializer
  attributes :id, :name, :color
  belongs_to :group
  has_many :tasks
end
