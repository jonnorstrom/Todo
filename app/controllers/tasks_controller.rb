class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render :show
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    Task.find(params[:id]).destroy

    redirect_to tasks_path
  end


  private

  def task_params
    params.require(:task).permit(:name, :priority)
  end
end
