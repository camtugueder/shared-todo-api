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
    if @task.update(task_params)
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
