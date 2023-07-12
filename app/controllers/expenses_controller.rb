class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /expenses or /expenses.json
  def index
    @expenses = Expense.all
    @category = Category.find(params[:category_id])
  end

  # GET /expenses/1 or /expenses/1.json
  def show
    @category = Category.find(params[:category_id])
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @category = Category.find(params[:category_id])
    @expense = @category.expenses.build(author_id: current_user.id, **expense_params)
  
    respond_to do |format|
      if @expense.save
        format.html { redirect_to category_expense_url(@category, @expense), notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to category_expense_url(@category, @expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @category = Category.find(params[:category_id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to category_expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :amount)
    end
end
