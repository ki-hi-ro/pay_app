json.extract! payment, :id, :group_id, :payer_id, :amount, :description, :created_at, :updated_at
json.url payment_url(payment, format: :json)
