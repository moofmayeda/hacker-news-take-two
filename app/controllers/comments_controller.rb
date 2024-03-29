class CommentsController < ApplicationController
  def new
    if params[:comment_id] == nil
      @post = Link.find(params[:link_id])
    else
      @post = Comment.find(params[:comment_id])
    end
    @comment = @post.comments.new
  end

  def create
    if params[:comment_id] == nil
      @post = Link.find(params[:link_id])
    else
      @post = Comment.find(params[:comment_id])
    end
    @comment = @post.comments.new(comment_params)
    @link = @comment.find_parent
    if @comment.save
      redirect_to link_path(@link), notice: "New comment submitted! Congrats!"
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @link = @comment.find_parent
    @comment.destroy
    redirect_to link_path(@link), notice: "New comment destroyed! Way to go!"
  end

  def edit
    @comment = Comment.find(params[:id])
    render 'edit'
  end

  def update
    @comment = Comment.find(params[:id])
    @link = @comment.find_parent
    if @comment.update(comment_params)
      redirect_to link_path(@link), notice: "Comment updated! Congrats!"
    else
      render 'edit'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:description)
  end
end
