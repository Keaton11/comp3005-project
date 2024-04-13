json.extract! member, :id, :first_name, :last_name, :date_of_birth, :height, :weight
json.url member_url(member, format: :json)
