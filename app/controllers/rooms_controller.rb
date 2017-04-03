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
    # @issueTypes = IssueType.all
    @issuesForRoom = Issue.where("room_id = ?", room)
    # @reportedIssues = IssueType.joins("INNER JOIN issues ON issues.issue_type_id = issue_types.id AND issues.room_id = " + room)

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
    # @issueTypes.each do |issueType|
    #   issueEntity = IssueEntity.new
    #   issueEntity.issue_type = issueType.id
    #   issueEntity.room_id = room
    #   issueEntity.ok_icon = issueType.ok_icon
      
    #   if @reportedIssues.detect {|i| i.id == issueType.id} == nil 
    #     issueEntity.is_done = false
    #   else
    #     issueEntity.is_done = true
    #   end

    #   issueEntity.issue_description = issueType.issue_description

    #   @issues.push(issueEntity)
    # end
  end

  # def report
  #   @issueTypes = IssueType.all
  #   room = params[:room_id]
  #   @reportedIssues = IssueType.joins("INNER JOIN issues ON issues.issue_type_id = issue_types.id AND issues.room_id = "+ room)
  #   @otherIssues = []
  #   @issueTypes.each do |issue|
  #     if @reportedIssues.detect {|i| i.id == issue.id} == nil
  #       @otherIssues.push(issue)
  #     end
  #   end
  # end

  def markIssue
    room = params[:room]
    issueType = params[:issueType]
    puts room
    puts issueType

    # @issue = Issue.find(:first, :conditions => [ "room_id = ? AND issue_type_id = ?", room, issueType])
    @issue = Issue.where("room_id = ? AND issue_type_id = ?", room, issueType).first

    currentValue = @issue.is_done
    @issue.update_attribute(:is_done, !currentValue)

    puts ""
    puts "koniec"
    puts ""
    # @issue.is_done = !currentValue
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
