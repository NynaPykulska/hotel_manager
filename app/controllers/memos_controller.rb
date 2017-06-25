class MemosController < ApplicationController
   	
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  include MemoHelper       
  @stored_date = nil

 	def list
    if params[:date].blank?
      @date = Date.current();
    else
      @date = Date.strptime(params[:date], "%Y-%m-%d")
    end

    @memos = Memo.where('deadline BETWEEN ? AND ?', @date.beginning_of_day, @date.end_of_day).all
    @stored_date = @date
    @done = 0
    @not_done = 0

    @memos.each do |m|
      m.is_done ? @done+=1 : @not_done+=1
    end
 	end

  def mark_ready
    @memo = Memo.find(params[:id])
    @memo.update_attribute(:is_done, true)
    @memo.is_done = true
    render :nothing => true
  end

  def reopen
    @memo = Memo.find(params[:id])
    @memo.update_attribute(:is_done, false)
    @memo.is_done = false
    render :nothing => true
  end

 	def create
    @room = Room.where("room_id = ?", memo_params[:room_id]).first

    if(memo_params[:is_recurring] == "0")
      @date = DateTime.strptime(memo_params["deadline"], '%Y-%m-%d').change({ hour: memo_params["deadline(4i)"].to_i, min: memo_params["deadline(5i)"].to_i})  
      puts @date
      puts memo_params[:deadline]
      @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: @date, is_done: memo_params[:is_done], is_recurring: false )
      redirect_back(fallback_location: root_path)

    else
      start_date = DateTime.strptime(memo_params["start_date"], '%Y-%m-%d')
      end_date = DateTime.strptime(memo_params["end_date"], '%Y-%m-%d')

      # Generate a unique ID for an event
      id = DateTime.now.strftime("%Y%m%d%k%M%S%L")
      id = id.to_i.to_s(36)
      id = id.to_i(36)

      case memo_params[:recurrence]
      when "1"
        (start_date.to_i .. end_date.to_i).step(1.day) do |f|
          puts Time.at(f)
          @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: Time.at(f), is_done: memo_params[:is_done], is_recurring: true, event_id: id )
        end
        redirect_back(fallback_location: root_path)
      when "2"
        (start_date.to_i .. end_date.to_i).step(7.day) do |f|
          puts Time.at(f)
          @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: Time.at(f), is_done: memo_params[:is_done], is_recurring: true, event_id: id )
        end
        redirect_back(fallback_location: root_path)
      when "3"
        requested_day = start_date.day
        start_date = start_date.change(day: 1)
        max_days = 0
        while start_date < end_date
          max_days = Time.days_in_month(start_date.month, start_date.year)
          if(requested_day <= max_days)
            @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: start_date.change(day: requested_day), is_done: memo_params[:is_done], is_recurring: true, event_id: id )
          else
            @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: start_date.change(day: max_days), is_done: memo_params[:is_done], is_recurring: true, event_id: id )
          end
          start_date = start_date + 1.month
        end       
        redirect_back(fallback_location: root_path)
      when "4"
        pattern = memo_params[:pattern].delete(' ').split(",").map(&:to_i)
        
        start_date = start_date.change(day: 1)
        max_days = 0

        while start_date < end_date
          max_days = Time.days_in_month(start_date.month, start_date.year)
          pattern.each do |day|
            if(day <= max_days)
              @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: start_date.change(day: day), is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp], is_recurring: true, event_id: id )
            else
              @memo = @room.memos.create(room_id: memo_params[:room_id], description: memo_params[:description], deadline: start_date.change(day: max_days), is_done: memo_params[:is_done], time_stamp: memo_params[:time_stamp], is_recurring: true, event_id: id )
            end
          end
          start_date = start_date + 1.month
        end

        redirect_back(fallback_location: root_path)
      end
    end
  end
   
	def memo_params
   		params.require(:memo).permit(:room_id, :description, :deadline, :memo_time, :is_done, :is_recurring, :start_date, :end_date, :recurrence, :pattern)
	end

 	def edit
    @c = Memo.find(params[:id])
  end
   
 	def update
    @memo = Memo.find(params[:id])
    @memo.update_attributes(memo_params)
    redirect_back(fallback_location: root_path)
  end
   
 	def delete
 		Memo.find(params[:id]).destroy
 		redirect_to :back
 	end

  def delete_recurrence
    Memo.where(:event_id => params[:event_id]).destroy_all
    redirect_to :back
  end								
end