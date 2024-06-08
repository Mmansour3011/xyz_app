class TodosController < ApplicationController
include(TodosHelper)

  before_action :set_todo, only: %i[ show edit update destroy ]
  # GET /todos
  def index
    @todos=current_user.todos
  end

  # GET /todos/1
  def show
    redirect_to(root_url , status: :see_other) unless current_user == @todo.user
    @users=User.all.where(soft_delete: false, admin: false).where.not(id: current_user.id).where.not(id: @todo.shared_users.pluck(:id))
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
    redirect_to(root_url , status: :see_other) unless current_user == @todo.user
  end

  # POST /todos
  def create
    @todo = current_user.todos.create(todo_params)

    if @todo.save
      redirect_to @todo, notice: "Todo was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy!
    redirect_to todos_url, notice: "Todo was successfully destroyed.", status: :see_other
  end

  def share
    @todo=Todo.find(params[:id])
    users=User.where(id: params[:user_ids])
    if @todo.share_with(users) && users.present?
      redirect_to @todo, notice: "Todo shared successfully"
    else
      redirect_to @todo, alert: "Failed to share todo."
    end
  end

  def share_params
    params.require(:todo).permit(user_ids: [])
  end

  def index_shared
    #updated to make it show the shared todos of active users only...
    @shared_todos = current_user.shared_todos.joins(:user).where(users: { soft_delete: false })
  end
end
