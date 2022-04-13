class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show edit update destroy]

  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    #need this so that the error messages on the new html page
    # can go through without an article being created yet (fixes nil error)
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was created successfully!"
      redirect_to article_path(@article)
    else
      render :new
    end
    # path needs an id so you pass it the article instance variable that already has id
    # render plain: @article.inspect
  end

  def edit
  end

  def update

    if @article.update(article_params)
      flash[:notice] = "Article was updatedsuccessfully!"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
