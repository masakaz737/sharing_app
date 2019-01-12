json.extract! item, :id, :user_id, :name, :description, :condition, :price, :available, :created_at, :updated_at
json.url item_url(item, format: :json)
