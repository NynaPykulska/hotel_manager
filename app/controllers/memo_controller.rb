class MemoController < ApplicationController
   	
    protect_from_forgery with: :null_session
    before_filter :authenticate_user!

   include MemoHelper

    @stored_date = nil         

   	def list
        if params[:date].blank?
          @date = Date.current();

        else
          @date = Date.strptime(params[:date], "%Y-%m-%d")
        end
        @stored_date = @date
        @memos = Memo.where('deadline BETWEEN ? AND ?', @date.beginning_of_day, @date.end_of_day).all

        @done = 0
        @not_done = 0

        @memos.each do |m|
          m.is_done ? @done+=1 : @not_done+=1
        end
   	end

    def mark_ready
       @memo = Memo.find(params[:id])
       @memo.update_attribute(:is_done, true)
       @memo.update_attribute(:completion_date, Date.today)
       render :nothing => true
       # redirect_to :action => 'list'
    end

    def reopen
      @memo = Memo.find(params[:id])
      @memo.update_attribute(:is_done, false)
      render :nothing => true
      # redirect_to :action => 'list'
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

    if(memo_params[:is_recurring] == "0")
      puts "Standard"
      @date = DateTime.new(params[:memo]["completion_date(1i)"].to_i, params[:memo]["completion_date(2i)"].to_i ,params[:memo]["completion_date(3i)"].to_i, params[:memo]["memo_time(4i)"].to_i, params[:memo]["memo_time(5i)"].to_i)
      @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: @date, completion_date: memo_params[:completion_date], is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp] )
      redirect_to :back

    else
      puts "Non-standard"
      start_date =  DateTime.new(params[:memo]["start_date(1i)"].to_i, params[:memo]["start_date(2i)"].to_i ,params[:memo]["start_date(3i)"].to_i, params[:memo]["memo_time(4i)"].to_i, params[:memo]["memo_time(5i)"].to_i)
      end_date =    DateTime.new(params[:memo]["end_date(1i)"].to_i, params[:memo]["end_date(2i)"].to_i ,params[:memo]["end_date(3i)"].to_i, params[:memo]["memo_time(4i)"].to_i, params[:memo]["memo_time(5i)"].to_i)
      case memo_params[:recurrence]
      when "1"
        puts "codziennie"
        (start_date.to_i .. end_date.to_i).step(1.day) do |f|
          puts Time.at(f)
          @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: Time.at(f), completion_date: memo_params[:completion_date], is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp] )
        end
        redirect_to :back
      when "2"
        puts "co tydzien"
        (start_date.to_i .. end_date.to_i).step(7.day) do |f|
          puts Time.at(f)
          @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: Time.at(f), completion_date: memo_params[:completion_date], is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp] )
        end
        redirect_to :back
      when "3"
        puts "co miesiac"
        requested_day = start_date.day
        start_date = start_date.change(day: 1)
        max_days = 0
        while start_date < end_date
          max_days = Time.days_in_month(start_date.month, start_date.year)
          if(requested_day <= max_days)
            @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: start_date.change(day: requested_day), completion_date: memo_params[:completion_date], is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp] )
          else
            @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: start_date.change(day: max_days), completion_date: memo_params[:completion_date], is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp] )
          end
          start_date = start_date + 1.month
        end       
        redirect_to :back
      when "4"
        puts "custom"
      end
    end
  end
   
	def memo_params
   		params.require(:memo).permit(:room_id, :description, :completion_date, :memo_time, :time_stamp, :is_done, :is_recurring, :start_date, :end_date, :recurrence, :pattern)
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
 		redirect_to :back
 	end

 	def show_rooms
 		@room = Room.find(params[:id])
	end											

end