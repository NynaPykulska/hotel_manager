  class AddIconColumnsToIssueTypes < ActiveRecord::Migration
    def self.up
      add_attachment :issue_types, :icon
    end

    def self.down
      remove_attachment :issue_types, :icon
    end
  end