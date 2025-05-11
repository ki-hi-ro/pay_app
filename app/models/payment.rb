class Payment < ApplicationRecord
  belongs_to :payer, class_name: "User"
  has_many :debts, dependent: :destroy

  attr_accessor :debtor_ids

  after_create :generate_debts

  def generate_debts
    return if debtor_ids.nil?

    selected_debtor_ids = debtor_ids.reject(&:blank?).map(&:to_i)

    # 支払者本人を除外
    selected_debtor_ids -= [payer.id]

    return if selected_debtor_ids.empty?

    total_people_count = selected_debtor_ids.size + 1  # 支払者含む
    share = (amount.to_f / total_people_count).round(0)

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