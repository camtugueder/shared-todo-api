# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  # Setup for tests
  let(:group) { create(:group) }
  let(:friend) { create(:friend, group: group) }
  let(:another_friend) { create(:friend, group: group) }
  let(:friend_in_different_group) { create(:friend) } # Automatically creates another group

  describe 'associations' do
    it { should belong_to(:friend) }
  end

  describe 'acts_as_list' do
    it 'orders tasks in a friend list correctly' do
      first_task = create(:task, friend: friend)
      second_task = create(:task, friend: friend)
      expect(second_task.position).to be > first_task.position
    end

    it 'reorders tasks when a task is deleted' do
      first_task = create(:task, friend: friend)
      second_task = create(:task, friend: friend)
      first_task.destroy
      expect(second_task.reload.position).to eq(1)
    end

    it 'adjusts positions correctly when the middle task of three is deleted' do
      task1 = create(:task, friend: friend)
      task2 = create(:task, friend: friend)
      task3 = create(:task, friend: friend)

      task2.destroy  # Delete the middle task

      expect(task1.reload.position).to eq(1)
      expect(Task.find_by(id: task2.id)).to be_nil  # Ensure task2 is deleted
      expect(task3.reload.position).to eq(2)  # The order of task3 should be adjusted
    end

    it 'adjusts positions correctly when a new task is inserted between two tasks' do
      friend = create(:friend)
      task1 = create(:task, friend: friend)
      task2 = create(:task, friend: friend)

      # Insert a new task between task1 and task2
      new_task = create(:task, friend: friend)
      new_task.insert_at(2)

      expect(task1.reload.position).to eq(1)
      expect(new_task.reload.position).to eq(2)
      expect(task2.reload.position).to eq(3)
    end
  end

  describe 'validations' do
    context 'friend_in_same_group' do
      it 'allows moving task within the same group' do
        task = create(:task, friend: friend)
        task.update(friend: another_friend)
        expect(task.errors).to be_empty
      end

      it 'does not allow moving task to a friend in a different group' do
        task = create(:task, friend: friend)
        task.update(friend: friend_in_different_group)
        expect(task.errors.full_messages).to include("Friend cannot change to a friend in a different group")
      end
    end
  end
end