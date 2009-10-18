class HerokuConfiguration < Configuration
  preference :bucket, :string, :default => "mys3bucket"
  preference :access_key_id, :string, :default => 'my-access-key'
  preference :secret_access_key, :string, :default => 'my-secret-access-key'
end