# Comments controller can create, update, delete a comment by activity
class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

  # Add a message by an activity
  def create
    comment = Comment.new(comment_params)

    if comment.save
      flash[:success] = t('flash.comment_added')
    else
      flash[:error] = t('flash.comment_not_added')
    end
    redirect_to :back
  end

  # Edit a comment by activity
  def update

  end

  # Destroy a comment by activity
  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:user_id,
                                    :activity_id,
                                    :message,
                                    :commentable_id,
                                    :commentable_type)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
