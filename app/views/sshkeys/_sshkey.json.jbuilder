json.extract! sshkey, :id, :user_id, :key, :created_at, :updated_at
json.url sshkey_url(sshkey, format: :json)
