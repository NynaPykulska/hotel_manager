class RoomsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_filter :init_items_size_list
  before_filter :authenticate_user!



  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to controller: 'room', action: 'list', group: 'all'
    else
      render :action => 'new'
    end
  end

  def list
    @room = Room.new
    @issueTypes = IssueType.all

    if params[:group] == "all"
      @rooms = Room.all
    elsif params[:group] == "open"
      @rooms = Room.where("is_clean = ?", false)
    else params[:group] == "ready"
      @rooms = Room.where("is_clean = ?", true)
    end
  end

  def room_params
    params.require(:room).permit(:room_nid, :description)
  end

  def init_items_size_list
    @items_size_list ||= [Room.all.size, Room.where("is_clean = ?", false).size, Room.where("is_clean = ?", true).size]
    #                             0                           1                                       2
  end 

  def report_modal
    room = params[:room_id]
    @issueTypes = IssueType.all
    @reportedIssues = IssueType.joins("INNER JOIN issues ON issues.issue_type_id = issue_types.id AND issues.room_id = " + room)

    @issuesForRoom = Array.new

    @issueTypes.each do |issueType|
      issueEntity = IssueEntity.new
      issueEntity.issue_type = issueType.id
      issueEntity.room_id = room
      issueEntity.ok_icon = issueType.ok_icon
      
      if @reportedIssues.detect {|i| i.id == issueType.id} == nil 
        issueEntity.is_done = false
      else
        issueEntity.is_done = true
      end

      issueEntity.issue_description = issueType.issue_description

      @issuesForRoom.push(issueEntity)
    end
  end

  def report
    @issueTypes = IssueType.all
    room = params[:room_id]
    @reportedIssues = IssueType.joins("INNER JOIN issues ON issues.issue_type_id = issue_types.id AND issues.room_id = "+ room)
    @otherIssues = []
    @issueTypes.each do |issue|
      if @reportedIssues.detect {|i| i.id == issue.id} == nil
        @otherIssues.push(issue)
      end
    end

    def markIssue
      room = params[:room]
      issueType = params[:issue]
      value = params[:value]

      @issue = Issues.find(:first, :conditions => [ "room_id = ? AND issue_type = ?", room, issueType])
      @issue.update_attribute(:is_done, value)
      @issue.is_done = false
      render :nothing => true
    end
  end


end

class IssueEntity
  class_attribute :issue_type
  class_attribute :room_id
  class_attribute :is_done
  class_attribute :issue_description
  class_attribute :ok_icon
end
