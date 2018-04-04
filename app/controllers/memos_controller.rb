# Controller for managing memos for the receptioninst.
# A memo is a simple task concerning guests in a certain
# room. It may be a wake-up call, calling them a taxi etc.
# Therefore very memo is associated with a single room and
# has a due date.
#
# The receptionist can list all the memos, view them for a
# certain date, create new memos and delete them, mark
# memos as ready and re-open them, also edit and delete.
class MemosController < ApplicationController
  protect_from_forgery with: :null_session
  before_action do
    require_login('receptionist')
  end

  include MemoHelper
  $stored_date = nil

  def list
    @date = if params[:date].blank?
              Date.current
            else
              Date.strptime(params[:date], '%Y-%m-%d')
            end

    @memos = Memo.where('deadline BETWEEN ? AND ? AND is_pinned = ?',
                        @date.beginning_of_day,
                        @date.end_of_day,
                        false).all
    @pinned_memos = Memo.where("is_pinned = ?", true)

    $stored_date = @date
    @done = 0
    @not_done = 0

    (@memos | @pinned_memos).each do |m|
      m.is_done ? @done += 1 : @not_done += 1
    end
  end

  def mark_ready
    @memo = Memo.find(params[:id])
    @memo.update_attribute(:is_done, true)
    @memo.is_done = true
    render body: nil
  end

  def reopen
    @memo = Memo.find(params[:id])
    @memo.update_attribute(:is_done, false)
    @memo.is_done = false
    render body: nil
  end

  def get_formatted_date(date_name)
    date = DateTime.strptime(memo_params[date_name], '%Y-%m-%d')
    return Time.zone.local(date.year,
                           date.month,
                           date.day,
                           memo_params['deadline(4i)'].to_i,
                           memo_params['deadline(5i)'].to_i,
                           0)
  end

  def create_memo_object(date, is_recurring = false, event_id = nil)
    room = Room.where('room_id = ?', memo_params[:room_id]).first
    room.memos.create(room_id: memo_params[:room_id],
                      description: memo_params[:description],
                      deadline: date,
                      is_done: memo_params[:is_done],
                      is_pinned: memo_params[:is_pinned],
                      author: current_user.name + ' ' + current_user.surname,
                      is_recurring: is_recurring,
                      event_id: event_id)
  end

  def create_pattern
    schedule = IceCube::Schedule.new(Time.now)
    case memo_params[:recurrence]
    when '1'
      schedule.add_recurrence_rule IceCube::Rule.daily
    when '2'
      schedule.add_recurrence_rule IceCube::Rule.weekly
    when '3'
      schedule.add_recurrence_rule IceCube::Rule.monthly
    when '4'
      pattern = memo_params[:pattern].delete(' ').split(',').map(&:to_i)
      pattern.each do |day|
        schedule.add_recurrence_rule IceCube::Rule.monthly.day_of_month(day)
      end
    end
    return schedule
  end

  def get_all_recurences(start_date, end_date)
    schedule = create_pattern
    return schedule.occurrences_between(start_date.beginning_of_day, end_date.end_of_day)
  end

  def create
    if memo_params[:is_recurring] == '0'
      date = get_formatted_date('deadline')
      create_memo_object(date)
    else
      start_date = get_formatted_date('start_date')
      end_date = get_formatted_date('end_date')

      # Generate a unique ID for an event
      id = DateTime.now.strftime('%Y%m%d%k%M%S%L')
      id = id.to_i.to_s(36)
      id = id.to_i(36)
      all_recurences = get_all_recurences(start_date, end_date)

      all_recurences.each do |recurrence|
        create_memo_object(recurrence, true, id)
      end
    end
    redirect_back fallback_location: root_path
  end

  def memo_params
    params.require(:memo).permit(:room_id,
                                 :description,
                                 :deadline,
                                 :memo_time,
                                 :is_done,
                                 :is_recurring,
                                 :start_date,
                                 :end_date,
                                 :recurrence,
                                 :pattern,
                                 :is_pinned)
  end

  def edit
    @c = Memo.find(params[:id])
  end

  def update
    @memo = Memo.find(params[:id])
    @memo.update_attributes(memo_params)
    redirect_back fallback_location: root_path
  end

  def delete
    Memo.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  def delete_recurrence
    Memo.where(event_id: params[:event_id]).destroy_all
    redirect_back fallback_location: root_path
  end

  def pin
    @memo = Memo.find(params[:id])
    @memo.toggle!(:is_pinned)
    render body: nil
  end
end
