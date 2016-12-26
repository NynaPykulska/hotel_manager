class MemoController < ApplicationController
   	
   	def list
   		@memos = Memo.all
   	end

   	def list_open																																						
   		@memos = Memo.where("is_done = ?", true)
   	end

   	def list_ready
   		@memos = Memo.where("is_done = ?", false)
   	end
   
   	def show
   		@memo = Memo.find(params[:id])
   	end
   
   	def new
   		@memo = Book.new
   		@rooms = Room.all
   	end
   
   	def create
	   @memo = Memo.new(memo_params)
		
	   if @memo.save
	      redirect_to :action => 'list'
	   else
	      @rooms = Room.all
	      render :action => 'new'
	    end
   	end
   
	def memo_params
   		params.require(:memos).permit(:room_no, :description, :completion_date)
	end

   	def edit
   		@book = Memo.find(params[:id])
   		@rooms = Room.all
   	end
   
   	def update
   		@book = Memo.find(params[:id])
	
	   	if @memo.update_attributes(memo_param)
	      redirect_to :action => 'show', :id => @memo
	   	else
	      @rooms = Room.all
	      render :action => 'edit'
	   end
   	end

   	def memo_param
   		params.require(:memo).permit(:room_no, :description, :completion_date)
	end
   
   	def delete
   		Memo.find(params[:id]).destroy
   		redirect_to :action => 'list'
   	end

   	def show_rooms
   		@room = Room.find(params[:id])
	end

end