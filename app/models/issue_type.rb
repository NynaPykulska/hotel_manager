class IssueType < ApplicationRecord
	has_attached_file :icon
	validates_attachment_content_type :icon, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
