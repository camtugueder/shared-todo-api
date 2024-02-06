require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let!(:group) { create(:group) }
  let!(:friend1) { create(:friend, group: group) }
  let!(:friend2) { create(:friend, group: group) }

  # Create multiple tasks for friend1 and friend2
  let!(:task1) { create(:task, friend: friend1, position: 1) }
  let!(:task2) { create(:task, friend: friend1, position: 2) }
  let!(:task3) { create(:task, friend: friend1, position: 3) }
  let!(:task4) { create(:task, friend: friend2, position: 1) }
  let!(:task5) { create(:task, friend: friend2, position: 2) }

  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { friend_id: friend2.id, position: 2 } }

    it 'moves a task from one friend to another and updates positions correctly' do
      # Update task2 to move it from friend1 to friend2
      put "/tasks/#{task2.id}", params: { task: valid_attributes }

      expect(response).to have_http_status(:ok)
      task1.reload
      task2.reload
      task3.reload
      task4.reload
      task5.reload

      # Verify the positions after moving task2
      expect(task1.position).to eq(1)   # Position of task1 should remain unchanged
      expect(task2.position).to eq(2)   # task2 is now the second task of friend2
      expect(task2.friend).to eq(friend2)   # Ensure task2 is associated with friend2
      expect(task3.position).to eq(2)   # Position of task3 should be shifted to 2
      expect(task4.position).to eq(1)   # Position of task4 should remain unchanged
      expect(task5.position).to eq(3)   # Position of task5 should be shifted to 3 (task2 is now in position 2)
    end
  end
end
