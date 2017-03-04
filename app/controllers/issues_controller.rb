class IssuesController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authenticate_user!

	def create
		@issue = Issue.new(issue_params)

		if @room.save
		  redirect_to controller: 'issue', action: 'list'
		else
		  render :action => 'new'
		end
	end

	def list

    @issues = Issue.order('requested_fix_date')

    @done = 0
    @not_done = 0

    @issues.each do |m|
      m.is_done ? @done+=1 : @not_done+=1
    end

 	end

	def mark_ready
		@issue = Issue.find(params[:id])
		@issue.update_attribute(:is_done, true)
		@issue.update_attribute(:completion_date, Date.today)
		@issue.is_done = true
		render :nothing => true
	end

	def reopen
		@issue = Issue.find(params[:id])
		@issue.update_attribute(:is_done, false)
		@issue.update_attribute(:completion_date, nil)
		@issue.is_done = false
		render :nothing => true
	end

	def show
 		
 	end

	def issue_params
		params.require(:issue).permit(:room_id, :issue_type_id, :requested_fix_date, :fix_comment, :timestamp, :completion_date, :issue_type)
	end

	def create
		priority_list = ["Low", "Medium", "High"]

		@room = Room.where("room_id = ?", issue_params[:room_id]).first
		@date = DateTime.new(params[:issue]["requested_fix_date(1i)"].to_i, params[:issue]["requested_fix_date(2i)"].to_i ,params[:issue]["requested_fix_date(3i)"].to_i)
		@issue = @room.issues.create(room_id: issue_params[:room_id], fix_comment: issue_params[:fix_comment], requested_fix_date: @date, completion_date: nil, is_done: issue_params[:is_done], timestamp: issue_params[:timestamp], issue_type_id: issue_params[:issue_type], priority: priority_list[issue_params[:priority].to_i - 1])
		redirect_back(fallback_location: root_path)
	end

	def delete
 		Issue.find(params[:id]).destroy
 		redirect_back(fallback_location: root_path)
 	end

 	def edit
    @c = Issue.find(params[:id])
  end
   
 	def update
    @issue = Issue.find(params[:id])
    @issue.update_attributes(issue_params)
    redirect_back(fallback_location: root_path)
  end

end
