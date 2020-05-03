json.extract! payment_detail, :id, :name, :card_number, :expiry, :cvv, :created_at, :updated_at
json.url payment_detail_url(payment_detail, format: :json)
