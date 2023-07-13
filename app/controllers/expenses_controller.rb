class ExpensesController < ApplicationController
  before_action :set_category
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /categories/:category_id/expenses
  def index
    @expenses = @category.expenses.order(created_at: :desc)
  end

  # GET /categories/:category_id/expenses/:id
  def show
  end

  # GET /categories/:category_id/expenses/new
  def new
    @expense = @category.expenses.new
  end

  # GET /categories/:category_id/expenses/:id/edit
  def edit
  end

  # POST /categories/:category_id/expenses
  def create
    @expense = Expense.new(author_id: current_user.id, **expense_params)
    
    if @expense.save
      @category.expenses << @expense
      redirect_to category_expenses_url(@category, @expense), notice: "Expense was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/:category_id/expenses/:id
  def update
    if @expense.update(expense_params)
      redirect_to category_expense_url(@category, @expense), notice: "Expense was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:category_id/expenses/:id
  def destroy
    @expense.destroy
    redirect_to category_expenses_url, notice: "Expense was successfully destroyed."
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_expense
    @expense = @category.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
