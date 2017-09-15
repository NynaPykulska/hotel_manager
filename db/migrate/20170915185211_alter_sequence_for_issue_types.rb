class AlterSequenceForIssueTypes < ActiveRecord::Migration[5.0]
  def change
  	execute "SELECT setval('issue_types_id_seq', 20)"
  end
end
