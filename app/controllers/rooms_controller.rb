class RoomsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_filter :init_items_size_list
  before_filter :authenticate_user!



  def create

    # @room = Room.new(room_params)
    @issues = IssueType.all

    @selectedIssues = room_params[:selectedIssues]
    @room_id = room_params[:room_id]
    @description = room_params[:description]

    @room = Room.create(room_id: @room_id.to_i, description: @description, is_clean: true)
    @selectedIssues.each do |d|
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
    params.require(:room).permit(:room_id, :description, :selectedIssues => [])
  end

  def init_items_size_list
    @items_size_list ||= [Room.all.size, Room.where("is_clean = ?", false).size, Room.where("is_clean = ?", true).size]
    #                             0                           1                                       2
  end 

  def report_modal
    room = params[:room_id]
    @issuesForRoom = Issue.where("room_id = ?", room)

    @issues = Array.new

    @issuesForRoom.each do |issue| 
      issueEntity = IssueEntity.new
      type = IssueType.where("id = ?", issue.issue_type_id).first
      issueEntity.issue_type = issue.issue_type_id
      issueEntity.room_id = room
      issueEntity.ok_icon = type.ok_icon
      issueEntity.is_done = issue.is_done
      issueEntity.issue_description = type.issue_description

      @issues.push(issueEntity)
    end
  end

  def markIssue
    room = params[:room]
    issueType = params[:issueType]

    @issue = Issue.where("room_id = ? AND issue_type_id = ?", room, issueType).first

    currentValue = @issue.is_done
    @issue.update_attribute(:is_done, !currentValue)

    render :nothing => true
  end
end

class IssueEntity
  class_attribute :issue_type
  class_attribute :room_id
  class_attribute :is_done
  class_attribute :issue_description
  class_attribute :ok_icon
end
