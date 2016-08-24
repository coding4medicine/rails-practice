json.extract! referral, :id, :OldEmail, :NewEmail, :old_id, :new_id, :bonuspaid, :created_at, :updated_at
json.url referral_url(referral, format: :json)
