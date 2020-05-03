json.extract! item, :id, :brand, :name, :category, :is_restricted, :is_age_restricted, :quantity, :cost, :taxslab, :purchase_count, :created_at, :updated_at
json.url item_url(item, format: :json)
