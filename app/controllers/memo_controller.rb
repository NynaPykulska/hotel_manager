class MemoController < ApplicationController
   	
    before_filter :authenticate_user!
    protect_from_forgery with: :null_session

   include MemoHelper

   	def list

        if params[:memo].blank?
          puts "is blank, man"
          # date = DateTime.new(2017,01,10).to_date
          if @stored_date.blank?
            @date = Date.current();
            puts @date
          else 
            @date = get_date
          end
        else
          # date = DateTime.strptime(params[:date_of_tour], "%Y-%m-%d")
          puts "is not empty, yo"
          puts params[:memo][:date]
          date = Date.strptime(params[:memo][:date], "%Y-%m-%d")
        end

        @memos = Memo.where(:deadline => date)

        @done = 0
        @not_done = 0

        @memos.each do |m|
          m.is_done ? @done+=1 : @not_done+=1
        end

   	end

    def get_date
      @date = @stored_date  
    end

    def mark_ready
       @memo = Memo.find(params[:id])
       @memo.update_attribute(:is_done, true)
       @memo.update_attribute(:completion_date, Date.today)
       # redirect_to :action => 'list'
    end

    def reopen
      @memo = Memo.find(params[:id])
      @memo.update_attribute(:is_done, false)
      redirect_to :action => 'list'
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
    @room = Room.where("room_id = ?", memo_params[:room_id]).first
    @date = DateTime.new(params[:memo]["completion_date(1i)"].to_i, params[:memo]["completion_date(2i)"].to_i ,params[:memo]["completion_date(3i)"].to_i, params[:memo]["memo_time(4i)"].to_i, params[:memo]["memo_time(5i)"].to_i)

    @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: @date, completion_date: memo_params[:completion_date], is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp] )
  
    if @memo.save
       redirect_to controller: 'memo', action: 'list', group: 'all'
    else
       @rooms = Room.all
       render :action => 'new'
    end

  end
   
	def memo_params
   		params.require(:memo).permit(:room_id, :description, :completion_date, :time_stamp, :is_done)
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