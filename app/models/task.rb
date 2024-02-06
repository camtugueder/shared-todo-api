class Task < ApplicationRecord
  belongs_to :friend
  acts_as_list scope: :friend

  validates :description, presence: true  # Ensure description cannot be empty

  # Validates that the task stays within the same group
  validate :friend_in_same_group, on: :update

  private
  def friend_in_same_group
    return if friend_id_was.nil? || friend_id == friend_id_was
    original_friend = Friend.find(friend_id_was)
    new_friend = Friend.find(friend_id)
    if original_friend.group_id != new_friend.group_id
      errors.add(:friend_id, "cannot change to a friend in a different group")
    end
  end
end
