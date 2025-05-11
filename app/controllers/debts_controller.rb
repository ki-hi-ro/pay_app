class DebtsController < ApplicationController
  before_action :set_debt, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:for_me, :index]

  # GET /debts or /debts.json
  def index
    # 自分が受け取る側の借金（＝自分が立て替えた分）
    @debts = Debt.includes(:from_user, :to_user).where(to_user: current_user).order(:due_date)
  end

  def for_me
    @debts = Debt
      .includes(:from_user, :to_user)
      .where(from_user_id: current_user.id)
      .where.not(to_user_id: current_user.id)
      .order(:due_date)
  end

  # GET /debts/1 or /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
  end

  # GET /debts/1/edit
  def edit
  end

  # GET /payments/:id/debts/edit
  def edit_for_payment
    @payment = Payment.includes(debts: :from_user).find(params[:id])
  end

  # POST /debts or /debts.json
  def create
    @debt = Debt.new(debt_params)

    respond_to do |format|
      if @debt.save
        format.html { redirect_to @debt, notice: "Debt was successfully created." }
        format.json { render :show, status: :created, location: @debt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debts/1 or /debts/1.json
  def update
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to payments_path, notice: "返済状況を更新しました。" }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end  

  def update_multiple
    params[:debts].each do |id, attributes|
      debt = Debt.find(id)
      debt.update(attributes.permit(:paid))
    end
    redirect_to payments_path, notice: "返済状況を更新しました。"
  end  

  # DELETE /debts/1 or /debts/1.json
  def destroy
    @debt.destroy!

    respond_to do |format|
      format.html { redirect_to debts_path, status: :see_other, notice: "Debt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def debt_params
      params.require(:debt).permit(:payment_id, :from_user_id, :to_user_id, :amount, :paid, :due_date)
    end
end
