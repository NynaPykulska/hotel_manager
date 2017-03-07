class IssueType < ApplicationRecord
	has_attached_file :ok_icon
	validates_attachment_content_type :ok_icon, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_attached_file :nok_icon
	validates_attachment_content_type :nok_icon, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
