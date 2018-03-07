# Controller for managing the issue that may arise
# in any room in the hotel. The user can list all
# unresolved issues, report new issue in a chosen room,
# mark them as resolved, re-open, delete and edit them.
class IssuesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action do
    require_login('maitenance')
  end

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
    resolver = current_user.name + ' ' + current_user.surname
    @issue.update_attributes(is_done: true,
                             completion_date: Date.today,
                             resolver: resolver)
    @all_room_issues = Issue.where('room_id = ? AND is_done = ?',
                                   @issue.room_id, false)
    if @all_room_issues.count.zero?
      @room = Room.where('room_id = ?', @issue.room_id).first
      @room.update_attribute(:is_clean, true)
    end
    render body: nil
  end

  def reopen
    @issue = Issue.find(params[:id])
    @issue.update_attribute(:is_done, false)
    @issue.update_attribute(:completion_date, Date.today)
    @room = Room.where('room_id = ?', @issue.room_id).first
    @room.update_attribute(:is_clean, false)

    render body: nil
  end

  def show; end

  def new
    @images = Dir.glob('app/assets/images/icons/issue/*.svg')
    @chosen_image = @images[0]
  end

  def create_issue_type
    IssueType.create(issue_description: params[:issue_type][:description],
                     default_priority: params[:issue_type][:priority],
                     icon_path: params[:issue_type][:icon_path])
    redirect_back fallback_location: root_path
  end

  def delete
    Issue.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end
end
