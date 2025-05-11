class Payment < ApplicationRecord
  belongs_to :payer, class_name: "User"
  has_many :debts, dependent: :destroy

  attr_accessor :debtor_ids

  after_create :generate_debts

  private

  def generate_debts
    return if debtor_ids.nil?

    selected_debtor_ids = debtor_ids.reject(&:blank?).map(&:to_i)

    # 自分自身を除外（再発防止）
    selected_debtor_ids -= [payer.id]
    
    return if selected_debtor_ids.empty?
  
    share = amount / selected_debtor_ids.size
  
    selected_debtor_ids.each do |user_id|
      debts.create!(
        from_user_id: user_id,
        to_user: payer,
        amount: share,
        paid: false,
        due_date: Date.today + 7
      )
    end
  end
end
