  class AddIconColumnsToIssueTypes < ActiveRecord::Migration
    def self.up
      add_attachment :issue_types, :ok_icon
      add_attachment :issue_types, :nok_icon
    end

    def self.down
      remove_attachment :issue_types, :ok_icon
      remove_attachment :issue_types, :nok_icon
    end
  end