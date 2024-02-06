class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :position
  belongs_to :friend
end
