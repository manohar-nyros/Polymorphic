class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    def index
    @articles = Article.all
  end

  def show
  end

  def new
     @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path, notice: "The article has been successfully created."
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to article_path, notice: "The article has been updated"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: "The article has been deleted"
  end
private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:name)
  end
end
