class IssueController < ApplicationController
	before_filter :authenticate_user!
	before_filter :init_items_size_list

	def create
	@issue = Issue.new(issue_params)

	if @room.save
	  redirect_to controller: 'issue', action: 'list', group: 'all'
	else
	  render :action => 'new'
	end
	end

	def list
		@issue = Issue.new

		if params[:group] == "all"
			@issues = Issue.all
		elsif params[:group] == "open"
			@issues = Issue.where('completion_date' => nil)
		else params[:group] == "ready"
			@issues = Issue.where.not('completion_date' => nil)
		end

		@issues.each do |c|
			puts c.room_id
		end
	end

	def issue_params
		params.require(:issue).permit(:room_id, :issue_type_id, :requested_fix_date, :fix_comment, :timestamp, :completion_date)
	end

	def init_items_size_list
	    @items_size_list ||= [Issue.all.size, Issue.where('completion_date' => nil).size, Issue.where.not('completion_date' => nil).size]
	    #                             0                           1                                       2
	end

end
