# Controller for managing the rooms available in the
# hotel. The rooms themselves are very simple - they are
# are identified by room number and can contain a description.
#
# New rooms can be created if needed, the existing ones can
# be edited and deleted. All the rooms can be viewed on a list
# containing all unresolved issues. The rooms are categorized as
# "clean" and "not clean" - respectively it means rooms that have
# no issues and those that have some unresolved issues assigned.
class RoomsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :init_items_size_list
  
  before_action do
    require_login("maid")
  end

  before_action :fetch_selected_issues, only: %i[edit]
  before_action :fetch_all_issue_types, only: %i[edit create]
  before_action :fetch_room_by_id, only: %i[edit update]
  before_action :fetch_all_rooms, only: %i[list]
  before_action :fetch_issues_by_room_id, only: %i[report_modal]

  def edit
    @selected_issue_types = []
    @selected_issues.each do |i|
      @selected_issue_types.push(i.issue_type_id)
    end
  end

  def update
    selected_issues = room_params[:selected_issues]
    room_id = room_params[:room_id]
    add_new_issues_to_room(selected_issues,
                           room_id)
    remove_old_issues_from_room(selected_issues,
                                room_id)
    check_if_room_clean_and_update(room_id,
                                   room_params[:description])
    redirect_back(fallback_location: root_path)
  end

  def create
    room_id = room_params[:room_id]
    room = Room.create(room_id: room_id,
                       description: room_params[:description],
                       is_clean: true,
                       is_other: room_params[:is_other])
    add_new_issues_to_room(room_params[:selected_issues], room_id)
    if room.save
      redirect_back(fallback_location: root_path)
    else
      render action: 'new'
    end
  end

  def list; end

  def room_params
    params.require(:room).permit(:room_id, :is_other, :description, selected_issues: [])
  end

  def init_items_size_list
    @items_size_list ||= [Room.all.size, Room.where('is_clean = ?', false).size,
                          Room.where('is_clean = ?', true).size]
  end

  def report_modal
    @room_id = params[:room_id]
    @issues = create_issue_entities(@issues_for_room)
  end

  def create_issue_entities(issues_for_room)
    issues = []
    issues_for_room.each do |issue|
      type = IssueType.where('id = ?', issue.issue_type_id).first
      issue_entity = IssueEntity.new(issue.issue_type_id, params[:room_id],
                                     issue.is_done, type.issue_description,
                                     type.icon_path)
      issues.push(issue_entity)
    end
    return issues
  end

  def report_issue
    room_id = params[:room][:room_id]
    issue_type = params[:room][:issue_type]
    issue = Issue.where('room_id = ? AND issue_type_id = ?',
                        room_id, issue_type).first
    room = Room.where('room_id = ?', room_id).first
    current_value = issue.is_done
    reporter = current_user.name + " " + current_user.surname
    issue.update_attributes(is_done: !current_value,
                            fix_comment: params[:room][:comment],
                            report_date: Date.today,
                            completion_date: nil,
                            reporter: reporter,
                            resolver: nil)
    room.update_attribute(:is_clean, false)
    redirect_back(fallback_location: root_path)
  end

  # Helper methods

  def fetch_issues_by_room_id
    @issues_for_room = Issue.where('room_id = ?', params[:room_id])
  end

  def fetch_all_rooms
    @rooms = Room.all
  end

  def fetch_selected_issues
    @selected_issues = Issue.where(room_id: params[:id])
  end

  def fetch_all_issue_types
    @issues = IssueType.all
  end

  def fetch_room_by_id
    @room = Room.find(params[:id])
  end

  def add_new_issues_to_room(selected_issues, id)
    selected_issues.each do |issue|
      unless Issue.exists?(room_id: id, issue_type_id: issue.to_i) || issue.blank?
        Issue.create(room_id: id, issue_type_id: issue.to_i,
                     priority: 'Medium', is_done: true)
      end
    end
  end

  def remove_old_issues_from_room(selected_issues, id)
    @issues_for_room = Issue.where('room_id = ?', id)

    @issues_for_room.each do |issue|
      unless selected_issues.include? issue.issue_type_id.to_s
        Issue.where('room_id = ? AND issue_type_id = ?',
                    id, issue.issue_type_id).destroy_all
      end
    end
  end

  def check_if_room_clean_and_update(id, description)
    if Issue.exists?(room_id: id, is_done: false)
      @room.update(room_id: id,
                   description: description,
                   is_clean: false)
    else
      @room.update(room_id: id,
                   description: description,
                   is_clean: true)
    end
  end
end

# Helper class that aggregates parameters from different tables
# (rooms, issues) to easy access them in a view
class IssueEntity
  class_attribute :issue_type
  class_attribute :room_id
  class_attribute :is_done
  class_attribute :issue_description
  class_attribute :icon_path

  def initialize(issue_type, room_id, is_done, issue_description, icon_path)
    self.issue_type = issue_type
    self.room_id = room_id
    self.is_done = is_done
    self.issue_description = issue_description
    self.icon_path = icon_path
  end
end
