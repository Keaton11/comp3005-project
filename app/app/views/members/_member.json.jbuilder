json.extract! member, :id, :first_name, :last_name, :date_of_birth, :height, :weight, :created_at, :updated_at
json.url member_url(member, format: :json)
