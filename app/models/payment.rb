class Payment < ApplicationRecord
  belongs_to :group
  belongs_to :payer, class_name: "User"
  has_many :debts, dependent: :destroy

  after_create :generate_debts

  private

  def generate_debts
    # 支払者以外のグループメンバーを取得
    debtors = group.users.where.not(id: payer.id)
    # 一人あたりの金額を計算（整数切り捨て）
    share_amount = amount / debtors.count

    debtors.each do |debtor|
      debts.create!(
        from_user: debtor,
        to_user: payer,
        amount: share_amount,
        paid: false,
        due_date: Date.today + 7  # 仮の返済予定日（1週間後）
      )
    end
  end  
end
