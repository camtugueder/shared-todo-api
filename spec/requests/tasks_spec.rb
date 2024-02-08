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
  let!(:task6) { create(:task, friend: friend1, position: 4) }


  describe 'PUT /tasks/:id' do
    describe 'moving a task between friends' do
      context 'to a new friend with enough tasks to maintain the original position' do
        before do
          put task_path(task2), params: { task: { friend_id: friend2.id, position: 2 } }
          [task1, task2, task3, task4, task5].each(&:reload)
        end

        it 'updates the task’s friend and maintains its position' do
          expect(task2.friend).to eq(friend2)
          expect(task2.position).to eq(2)
        end

        it 'adjusts the positions of the remaining tasks in both friends lists' do
          expect(task1.position).to eq(1)
          expect(task3.position).to eq(2) # Adjusted due to task2 moving
          expect(task4.position).to eq(1)
          expect(task5.position).to eq(3) # Adjusted to accommodate task2
        end
      end

      context 'to a new friend where the original position is preserved' do
        before do
          put task_path(task3), params: { task: { friend_id: friend2.id } }
          [task1, task2, task3, task4, task5].each(&:reload)
        end

        it 'inserts the task at the same position in the new list' do
          expect(task3.friend_id).to eq(friend2.id)
          expect(task3.position).to eq(3)
        end
      end

      context 'to a new friend where the original position exceeds the number of items' do
        before do
          # Moving task6 from friend1 to friend2, where friend2 originally has 2 tasks, testing the boundary condition
          put task_path(task6), params: { task: { friend_id: friend2.id } }
          [task1, task2, task3, task4, task5, task6].each(&:reload)
        end

        it 'places the task at the last position in the new list because the original position exceeds the new list size' do
          expect(task6.friend_id).to eq(friend2.id)
          # Task6 should be placed at the last position because its original position (4) is more than friend2's task count before the move
          expect(task6.position).to eq(3) # Adjusted to be last in friend2's list
        end
      end
    end
  end
end
