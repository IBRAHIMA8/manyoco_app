class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    if params[:sort_expired]
      @tasks=current_user.tasks.orderByDeadline.kaminari(params[:page])
    else
      @tasks=current_user.tasks.ordered.kaminari(params[:page])
    end
    @user=current_user
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  #----------------------
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
        Task.current_user_sort(current_user.id).kaminari(params[:page])

        # The title has been entered
      elsif session[:search]['title'].present?
        # If status, priority were specified
        if session[:search]['status'].present? && session[:search]['priority'].present?
          Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).status_sort(session[:search]['status']).priority_sort(session[:search]['priority']).kaminari(params[:page])
          # If only priority and title is specified
        elsif session[:search]['status'].present?
          Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).status_sort(session[:search]['status']).kaminari(params[:page])
          #If only priority and title are specified
        elsif session[:search]['priority'].present?
          Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).status_sort(session[:search]['priority']).kaminari(params[:page])
        else
          Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).kaminari(params[:page])
        end

        # The title is empty and the status is specified
      elsif session[:search]['status'].present?
        # If priority and status are specified
        if session[:search]['priority'].present?
          Task.current_user_sort(current_user.id).search_sort(session[:search]['status']).priority_sort(session[:search]['priority']).kaminari(params[:page])
          # If only priority is specified
        else
          Task.current_user_sort(current_user.id).search_sort(session[:search]['status']).kaminari(params[:page])
        end

        # title, status is empty, and priority is specified
      elsif session[:search]['priority'].present?
        Task.current_user_sort(current_user.id).priority_sort(session[:search]['priority']).kaminari(params[:page])
      else
        Task.current_user_sort(current_user.id).kaminari(params[:page])
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
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
    params.require(:task).permit(:title, :content,:deadline,:priority,:status)
  end
end
