json.extract! card, :id, :token, :user_id, :last4, :created_at, :updated_at
json.url card_url(card, format: :json)
