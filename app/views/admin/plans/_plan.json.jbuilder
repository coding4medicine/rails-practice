json.extract! plan, :id, :stripe_id, :price, :period, :created_at, :updated_at
json.url plan_url(plan, format: :json)
