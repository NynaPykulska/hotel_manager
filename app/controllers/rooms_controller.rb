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
  before_filter :init_items_size_list
  before_filter :authenticate_user!

  before_action :fetch_selected_issues, only: [:edit]
  before_action :fetch_all_issues, only: [:edit]
  before_action :fetch_room_by_id, only: [:edit]

  def fetch_selected_issues
    @selected_issues = Issue.where(room_id: params[:id])
  end

  def fetch_all_issues
    @issues = IssueType.all
  end

  def fetch_room_by_id
    @room = Room.find(params[:id])
  end

  def edit 
    @selected_issue_types = []
    @selected_issues.each do |i|
      @selected_issue_types.push(i.issue_type_id)
    end
  end
   
  def update
    @room = Room.find(params[:id])
    id = room_params[:room_id]
    selected_issues = room_params[:selected_issues]
    @room.update(room_id: id, description: room_params[:description])
    Issue.where(room_id: id).delete_all
    
    selected_issues.each do |d|
      if not d.blank?
        Issue.create(room_id: id.to_i, issue_type_id: d.to_i, priority: "Medium", is_done: true, is_recurring: false)
      end
    end

    redirect_back(fallback_location: root_path)
  end

  def create

    # @room = Room.new(room_params)
    @issues = IssueType.all

    @selected_issues = room_params[:selected_issues]
    @room_id = room_params[:room_id]
    @description = room_params[:description]

    @room = Room.create(room_id: @room_id.to_i, description: @description, is_clean: true)
    @selected_issues.each do |d|
      if not d.blank?
        Issue.create(room_id: @room_id.to_i, issue_type_id: d.to_i, priority: "Medium", is_done: true, is_recurring: false)
      end
    end


    if @room.save
      redirect_back(fallback_location: root_path)
    else
      render :action => 'new'
    end
  end

  def list
    @issueTypes = IssueType.all
    @rooms = Room.all
  end

  def room_params
    params.require(:room).permit(:room_id, :description, :selected_issues => [])
  end

  def init_items_size_list
    @items_size_list ||= [Room.all.size, Room.where("is_clean = ?", false).size, Room.where("is_clean = ?", true).size]
    #                             0                           1                                       2
  end 

  def report_modal
    room = params[:room_id]
    @room_id = room
    @issuesForRoom = Issue.where("room_id = ?", room)

    @issues = Array.new

    @issuesForRoom.each do |issue| 
      issueEntity = IssueEntity.new
      type = IssueType.where("id = ?", issue.issue_type_id).first
      issueEntity.issue_type = issue.issue_type_id
      issueEntity.room_id =@room
      issueEntity.icon_path = type.icon_path
      issueEntity.is_done = issue.is_done
      issueEntity.issue_description = type.issue_description

      @issues.push(issueEntity)
    end
  end

  def report_issue
    room_id = params[:room][:room_id]
    issueType = params[:room][:issue_type]
    @issue = Issue.where("room_id = ? AND issue_type_id = ?", room_id, issueType).first
    @room = Room.where("room_id = ?", room_id).first
    currentValue = @issue.is_done
    @issue.update_attribute(:is_done, !currentValue)
    @issue.update_attribute(:fix_comment, params[:room][:comment])
    @issue.update_attribute(:completion_date, Date.today)
    @room.update_attribute(:is_clean, false)

    redirect_back(fallback_location: root_path)
  end
end

class IssueEntity
  class_attribute :issue_type
  class_attribute :room_id
  class_attribute :is_done
  class_attribute :issue_description
  class_attribute :icon_path
end
