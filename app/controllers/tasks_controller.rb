class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in, only: [:index,:create, :destroy]
    
    def index
      if logged_in?
        @task = current_user.tasks.build
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      end
    end
   
    
    def show 
    end 
    
    def new
        @task = Task.new
    end 
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = 'Task was successfully posted'
            redirect_to root_url
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = 'Task was not posted'
            render 'tasks/index'
        end 
    end 
    
    def edit 
    end 
    
    def update
        if @task.update(task_params)
            flash[:success] = 'Task was successfully updated'
            redirect_to root_path
        else
            flash.now[:danger] = 'Task was not updated'
            render :edit
        end 
    end 
    
    def destroy 
        @task.destroy
        flash[:success] = 'Task was deleted'
        redirect_to tasks_url
    end 
    
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end 
    
    
    def task_params
        params.require(:task).permit(:content, :status)
    end 
    
end
