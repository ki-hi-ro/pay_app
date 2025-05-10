# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
users = %w[あきら さゆり こうた なお].map { |name| User.create!(name: name) }
group = Group.create!(name: "飲み会")
group.users << users

payment = Payment.create!(
  group: group,
  payer: users.first,
  amount: 12000,
  description: "居酒屋予約"
)

share = payment.amount / (users.size - 1)
users[1..].each do |debtor|
  Debt.create!(
    payment: payment,
    from_user: debtor,
    to_user: users.first,
    amount: share,
    paid: false,
    due_date: Date.today + 7
  )
end