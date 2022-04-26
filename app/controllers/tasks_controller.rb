class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]


  def index
      if params[:sort_by_priority]
        @tasks=Task.all.orderByPriority
      elsif params[:sort_expired]
        @tasks=Task.all.orderByDeadline
      else
        @tasks = Task.all.ordered
      end
      @tasks = Task.page(params[:page]).per(5)
    end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    session[:search] = {'title' => params[:search_title], 'status' => params[:search_status], 'priority' => params[:search_priority]}
    @tasks = researched.ordered
    @search_title = session[:search]['title']
    render :index
  end

  def sort
    @tasks = researched.ordered
    @search_title = session[:search]['title']  if session[:search].present?
    session[:search] = nil
    render :index
  end


  def researched
      if session[:search].present?
        # If all searches are empty
        if session[:search]['title'].blank? && session[:search]['status'].blank? && session[:search]['priority'].blank?
          Task.kaminari(params[:page])

          # The title has been entered
        elsif session[:search]['title'].present?
          # If status, priority were specified
          if session[:search]['status'].present? && session[:search]['priority'].present?
            Task.search_sort(session[:search]['title']).status_sort(session[:search]['status']).priority_sort(session[:search]['priority']).kaminari(params[:page])
            # If only priority and title is specified
          elsif session[:search]['status'].present?
            Task.search_sort(session[:search]['title']).status_sort(session[:search]['status']).kaminari(params[:page])
            #If only priority and title are specified
          elsif session[:search]['priority'].present?
            Task.search_sort(session[:search]['title']).status_sort(session[:search]['priority']).kaminari(params[:page])
          else
            Task.search_sort(session[:search]['title']).kaminari(params[:page])
          end

          # The title is empty and the status is specified
        elsif session[:search]['status'].present?
          # If priority and status are specified
          if session[:search]['priority'].present?
            Task.status_sort(session[:search]['status']).priority_sort(session[:search]['priority']).kaminari(params[:page])
            # If only priority is specified
          else
            Task.status_sort(session[:search]['status']).kaminari(params[:page])
          end

          # title, status is empty, and priority is specified
        elsif session[:search]['priority'].present?
          Task.priority_sort(session[:search]['priority']).kaminari(params[:page])
        else
          Task.kaminari(params[:page])
        end
      end
    end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end


    def task_params
      params.require(:task).permit(:title, :content, :deadline, :priority, :status)
    end
end
