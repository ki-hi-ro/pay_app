class User < ApplicationRecord
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :payments, foreign_key: :payer_id
  has_many :debts_as_debtor, class_name: "Debt", foreign_key: :from_user_id
  has_many :debts_as_creditor, class_name: "Debt", foreign_key: :to_user_id
end
