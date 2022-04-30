class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    if params[:sort_expired]
      @tasks=current_user.tasks.orderByDeadline.kaminari(params[:page])
    else
      @tasks=current_user.tasks.ordered.kaminari(params[:page])
    end
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @label = @task.labelings.build
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end

  # GET /tasks/1/edit
  def edit
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
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

  def search
    session[:search] = {'title' => params[:search_title], 'status' => params[:search_status], 'priority' => params[:search_priority],'label'=>params[:search_label]}
     @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
    @tasks = researched.ordered
    @search_title = session[:search]['title']
    render :index
  end

  def sort
    @tasks = researched.ordered
    @search_title = session[:search]['title']  if session[:search].present?
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
    session[:search] = nil
    render :index
  end


  def researched
      if session[:search].present?
        # If all searches are empty
        if session[:search]['title'].blank? && session[:search]['label'].blank? && session[:search]['status'].blank? && session[:search]['priority'].blank?
          Task.current_user_sort(current_user.id).kaminari(params[:page])

          # The title has been entered
        elsif session[:search]['title'].present?
          # If status, priority were specified
          if session[:search]['status'].present? && session[:search]['priority'].present? && session[:search]['label'].present?
            Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).status_sort(session[:search]['status']).priority_sort(session[:search]['priority']).label_sort(session[:label]['status']).kaminari(params[:page])
            # If only priority and title is specified
          elsif session[:search]['status'].present? && session[:search]['priority'].present?
            Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).status_sort(session[:search]['status'])..label_sort(session[:search]['label']).kaminari(params[:page])
            #If only priority and title are specified
          elsif session[:search]['priority'].present?
            Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).status_sort(session[:search]['priority']).kaminari(params[:page])
          elsif session[:search]['label'].present?
            Task.current_user_sort(current_user.id).title_sort(session[:search]['title']).label_sort(session[:search]['label']).kaminari(params[:page])
          else
            Task.current_user_sort(current_user.id).search_sort(session[:search]['title']).kaminari(params[:page])
          end


          # The title is empty and the status is specified
        elsif session[:search]['status'].present?
          # If priority and status are specified
          if session[:search]['label'].present? && session[:search]['priority'].present?
            Task.current_user_sort(current_user.id).status_sort(session[:search]['status']).priority_sort(session[:search]['priority']).label_sort(session[:search]['label']).kaminari(params[:page])
            # If only priority is specified
          elsif session[:search]['priority'].present?
            Task.current_user_sort(current_user.id).priority_sort(session[:search]['priority']).status_sort(session[:search]['status']).kaminari(params[:page])
          elsif session[:search]['label'].present?
            Task.current_user_sort(current_user.id).label_sort(session[:search]['label']).status_sort(session[:search]['status']).kaminari(params[:page])
          else
            Task.current_user_sort(current_user.id).status_sort(session[:search]['status']).kaminari(params[:page])
          end

          #-------------------------
        elsif session[:search]['priority'].present?
          # If priority and status are specified
          if session[:search]['label'].present?
            Task.current_user_sort(current_user.id).label_sort(session[:search]['label']).priority_sort(session[:search]['priority']).kaminari(params[:page])
            # If only priority is specified
          else
            Task.current_user_sort(current_user.id).priority_sort(session[:search]['priority']).kaminari(params[:page])
          end


        elsif session[:search]['label'].present?
          Task.current_user_sort(current_user.id).label_sort(session[:search]['label']).kaminari(params[:page])


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
    params.require(:task).permit(:title, :content,:deadline,:priority,:status,label_ids: [])
  end
end
