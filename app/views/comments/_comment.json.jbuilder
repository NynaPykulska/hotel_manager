json.extract! comment, :id, :memo_id, :user_id, :username, :date, :comment_text, :created_at, :updated_at
json.url comment_url(comment, format: :json)
