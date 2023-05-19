class CommentsController < ApplicationController
  before_action :set_post

  def render_json
    @comments = @post.comments
    render json: @comments
  end

  def create
    @current_user = current_user
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_comments_path(@current_user.id, @post.id), notice: 'Comment posted.' }
        format.json { render json: @comment, status: :created }
      else
        format.html { render 'posts/show' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    authorize! :destroy, @post

    @comment.destroy
    redirect_to post_comments_path(@current_user), notice: 'Comment deleted successfully.'
  end

  private

  def set_post
    @post = Post.includes(:comments).find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
