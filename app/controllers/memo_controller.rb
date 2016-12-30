class MemoController < ApplicationController
   	
  	before_filter :init_items_size_list

   include MemoHelper

   	def list
         @memo = Memo.new

         if params[:group] == "all"
            @memos = Memo.all
         elsif params[:group] == "open"
            @memos = Memo.where("is_done = ?", false)
         else params[:group] == "ready"
   	      @memos = Memo.where("is_done = ?", true)
         end
   	end

      def mark_ready
         @memo = Memo.find(params[:id])
         @memo.update_attribute(:is_done, true)
         redirect_to :action => 'list', :group => "ready"
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
           redirect_to controller: 'memo', action: 'list', group: 'all'
                else
           @rooms = Room.all
           render :action => 'new'
         end
       end
   
	def memo_params
   		params.require(:memo).permit(:room_no, :description, :completion_date)
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

	def init_items_size_list
	    @items_size_list ||= [Memo.all.size, @memos = Memo.where("is_done = ?", true).size, @memos = Memo.where("is_done = ?", false).size]
	    #                             0                           1                                       2
	end															

end