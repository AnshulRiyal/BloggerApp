class CommentsController < ApplicationController
  before_action :require_login
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.try(:id)
    if @comment.save
      redirect_back fallback_location: root_path, notice: 'Your comment was successfully posted!'
    else
      redirect_back fallback_location: root_path, notice: "Your comment wasn't posted!"
    end
  end

  private

  #allowing access to current user logged in
  def require_login
    if not Rails.env.test?
      unless current_user
        redirect_to new_user_session_path
      end
    end
  end

  #strong parameters for comment CRUD
  def comment_params
    params.require(:comment).permit(:body)
  end

  #Fetching commentable for comment
  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end