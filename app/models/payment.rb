class Payment < ApplicationRecord
  belongs_to :group
  belongs_to :payer, class_name: "User"
  has_many :debts, dependent: :destroy
end
