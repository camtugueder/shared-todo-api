# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: [:update]

  def create
    task = Task.new(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    new_friend_id = task_params[:friend_id].to_i
    original_position = @task.position

    # Check if friend_id is changing
    if @task.friend_id != new_friend_id
      # Determine the last position for the new friend's tasks
      last_position = Task.where(friend_id: new_friend_id).maximum(:position) || 0

      # Adjust position for the task if necessary
      new_position = [original_position, last_position + 1].min

      # Update the task including the new position
      task_update_params = task_params.merge(position: new_position)
    else
      task_update_params = task_params
    end

    # Proceed with the update
    if @task.update(task_update_params)
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :status, :friend_id, :position)
  end
end
