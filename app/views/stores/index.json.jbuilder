json.array!(@stores) do |store|
  json.extract! store, :id, :name, :predator, :prey, :alpha, :beta, :gamma, :delta, :time, :increment, :user_id
  json.url store_url(store, format: :json)
end
