json.extract! debt, :id, :payment_id, :from_user_id, :to_user_id, :amount, :paid, :due_date, :created_at, :updated_at
json.url debt_url(debt, format: :json)
