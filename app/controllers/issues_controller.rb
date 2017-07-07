# Controller for managing the issue that may arise
# in any room in the hotel. The user can list all
# unresolved issues, report new issue in a chosen room,
# mark them as resolved, re-open, delete and edit them.
class IssuesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def list
    @issues = Issue.where('is_done = false or completion_date = ?', Date.today)
    @done = 0
    @not_done = 0
    @issues.each do |m|
      m.is_done ? @done += 1 : @not_done += 1
    end
  end

  def mark_ready
    @issue = Issue.find(params[:id])
    @issue.update_attribute(:is_done, true)
    @issue.update_attribute(:completion_date, Date.today)

    @all_room_issues = Issue.where('room_id = ? AND is_done = ?',
                                   @issue.room_id, false)
    if @all_room_issues.count.zero?
      @room = Room.where('room_id = ?', @issue.room_id).first
      @room.update_attribute(:is_clean, true)
    end
    render nothing: true
  end

  def reopen
    @issue = Issue.find(params[:id])
    @issue.update_attribute(:is_done, false)
    @issue.update_attribute(:completion_date, Date.today)
    @room = Room.where('room_id = ?', @issue.room_id).first
    @room.update_attribute(:is_clean, false)

    render nothing: true
  end

  def show; end

  def issue_params
    params.require(:issue).permit(:room_id, :issue_type_id,
                                  :requested_fix_date, :fix_comment,
                                  :timestamp, :completion_date,
                                  :issue_type, :is_recurring,
                                  :start_date, :end_date,
                                  :recurrence, :pattern, :priority)
  end

  def new
    @images = Dir.glob('app/assets/images/icons/issue/*.svg')
    @chosen_image = @images[0]
  end

  def create_issue_type
    id = IssueType.maximum(:id).next
    IssueType.create(id: id,
                     issue_description: params[:issue_type][:description],
                     default_priority: params[:issue_type][:priority],
                     icon_path: params[:issue_type][:icon_path])
    redirect_back(fallback_location: root_path)
  end

  def create
    priority_list = %w[Low Medium High]
    @room = Room.where('room_id = ?', issue_params[:room_id]).first

    if issue_params[:is_recurring] == '0'
      @date = Date.strptime(params[:issue]['requested_fix_date'], '%Y-%m-%d')
      @issue = @room.issues.create(room_id: issue_params[:room_id],
                                   fix_comment: issue_params[:fix_comment],
                                   requested_fix_date: @date,
                                   completion_date: nil,
                                   is_done: issue_params[:is_done],
                                   timestamp: issue_params[:timestamp],
                                   issue_type_id: issue_params[:issue_type],
                                   priority: priority_list[issue_params[:priority].to_i - 1])
      redirect_back(fallback_location: root_path)
    else
      start_date = DateTime.strptime(params[:issue]['start_date'], '%Y-%m-%d')
      end_date = DateTime.strptime(params[:issue]['end_date'], '%Y-%m-%d')

      # Generate a unique ID for an event
      id = DateTime.now.strftime('%Y%m%d%k%M%S%L')
      id = id.to_i.to_s(36)
      id = id.to_i(36)

      case issue_params[:recurrence]
      when '1'
        (start_date.to_i..end_date.to_i).step(1.day) do |f|
          puts Time.at(f)
          @issue = @room.issues.create(room_id: issue_params[:room_id],
                                       fix_comment: issue_params[:fix_comment],
                                       requested_fix_date: Time.at(f),
                                       completion_date: nil,
                                       is_done: issue_params[:is_done],
                                       timestamp: issue_params[:timestamp],
                                       issue_type_id: issue_params[:issue_type],
                                       priority: priority_list[issue_params[:priority].to_i - 1])
        end
        redirect_back(fallback_location: root_path)
      when '2'
        (start_date.to_i..end_date.to_i).step(7.day) do |f|
          puts Time.at(f)
          @issue = @room.issues.create(room_id: issue_params[:room_id],
                                       fix_comment: issue_params[:fix_comment],
                                       requested_fix_date: Time.at(f),
                                       completion_date: nil,
                                       is_done: issue_params[:is_done],
                                       timestamp: issue_params[:timestamp],
                                       issue_type_id: issue_params[:issue_type],
                                       priority: priority_list[issue_params[:priority].to_i - 1])
        end
        redirect_back(fallback_location: root_path)
      when '3'
        requested_day = start_date.day
        start_date = start_date.change(day: 1)
        max_days = 0
        while start_date < end_date
          max_days = Time.days_in_month(start_date.month, start_date.year)
          if requested_day <= max_days
            @issue = @room.issues.create(room_id: issue_params[:room_id],
                                         fix_comment: issue_params[:fix_comment],
                                         requested_fix_date: start_date.change(day: requested_day),
                                         completion_date: nil,
                                         is_done: issue_params[:is_done],
                                         timestamp: issue_params[:timestamp],
                                         issue_type_id: issue_params[:issue_type],
                                         priority: priority_list[issue_params[:priority].to_i - 1])
          else
            @issue = @room.issues.create(room_id: issue_params[:room_id],
                                         fix_comment: issue_params[:fix_comment],
                                         requested_fix_date: start_date.change(day: max_days),
                                         completion_date: nil,
                                         is_done: issue_params[:is_done],
                                         timestamp: issue_params[:timestamp],
                                         issue_type_id: issue_params[:issue_type],
                                         priority: priority_list[issue_params[:priority].to_i - 1])
          end
          start_date += 1.month
        end
        redirect_back(fallback_location: root_path)
      when '4'
        pattern = issue_params[:pattern].delete(' ').split(',').map(&:to_i)
        start_date = start_date.change(day: 1)
        max_days = 0

        while start_date < end_date
          max_days = Time.days_in_month(start_date.month, start_date.year)
          pattern.each do |day|
            if day <= max_days
              @issue = @room.issues.create(room_id: issue_params[:room_id], fix_comment: issue_params[:fix_comment], requested_fix_date: start_date.change(day: day), completion_date: nil, is_done: issue_params[:is_done], timestamp: issue_params[:timestamp], issue_type_id: issue_params[:issue_type], priority: priority_list[issue_params[:priority].to_i - 1])
            else
              @issue = @room.issues.create(room_id: issue_params[:room_id], fix_comment: issue_params[:fix_comment], requested_fix_date: start_date.change(day: max_days), completion_date: nil, is_done: issue_params[:is_done], timestamp: issue_params[:timestamp], issue_type_id: issue_params[:issue_type], priority: priority_list[issue_params[:priority].to_i - 1])
            end
          end
          start_date += 1.month
        end

        redirect_back(fallback_location: root_path)
      end
    end
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
