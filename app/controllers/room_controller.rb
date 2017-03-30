class RoomController < ApplicationController
	before_filter :init_items_size_list
  before_filter :authenticate_user!

  @reportedIssues = []
  @otherIssues = []

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

  def report
    @issueTypes = IssueType.all
    room = params[:id]
    @reportedIssues = IssueType.joins("INNER JOIN issues ON issues.issue_type_id = issue_types.id AND issues.room_id = ", room)
    @otherIssues = []
    @issueTypes.each do |issue|
      if @reportedIssues.detect {|i| i.id == issue.id} == nil
        @otherIssues.push(issue)
      end
    end
  end


end
