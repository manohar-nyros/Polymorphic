class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end


  def new
  	@commentable = find_commentable
    @comments = @commentable.comments.new
  end


  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    unless comment_params.nil?        
      @comment.save
    end

    if @comment.save
      redirect_to find_commentable_url(find_commentable), notice: "The comment has been successfully created."
    end
  end

  def edit
    @commentable = find_commentable
    @comment = find_commentable.comments.find(params[:id])
  end

  def update
    @commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to find_commentable_url(find_commentable), notice: "The comment has been updated"
    end
  end

  def destroy
    puts "comment deleted"
    redirect_to articles_url, notice: "The article has been deleted"
  end




private
  def comment_params
    params.require(:comment).permit!
  end

  def find_commentable
    if params[:article_id]
      id = params[:article_id]
      Article.find(params[:article_id])
    else
      id = params[:post_id]
      Post.find(params[:post_id])
    end
  end 

  def find_commentable_url(find_commentable)
    if Article === find_commentable
      article_path(find_commentable)
    else
      post_path(find_commentable)
    end
  end
end