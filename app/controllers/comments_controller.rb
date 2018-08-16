class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = Comment.new(memo_id: comment_params[:memo_id],
                           user_id: comment_params[:user_id],
                           comment_text: comment_params[:comment_text],
                           username: comment_params[:username],
                           date: comment_params[:date])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.js { render json: @comment, status: :created }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end
  
  def comment_params
    params.require(:comment).permit(:memo_id,
                                    :user_id,
                                    :comment_text,
                                    :username,
                                    :date)
  end
end
