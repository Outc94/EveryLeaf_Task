class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_first!

  def index
    @search = current_user.tasks.ransack(params[:q])
    if params[:q]
      @tasks = @search.result.page params[:page]
    elsif params[:sort_deadline]
      @tasks = current_user.tasks.order('end_at DESC').page params[:page]
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order('priority DESC').page params[:page]
    else
      @tasks = current_user.tasks.order('created_at DESC').page params[:page]
    end
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
      if @task.save
       redirect_to @task, notice: 'Task was successfully created'
      else
       render :new
    end
  end

  def update
      if @task.update(task_params)
         redirect_to @task, notice: 'Task was successfully updated'
      else
        render :edit
    end
  end

  def destroy
    @task.destroy
      redirect_to tasks_url, notice: 'Task was successfully deleted.'
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :status, :priority, :start_at, :end_at)
    end
end
