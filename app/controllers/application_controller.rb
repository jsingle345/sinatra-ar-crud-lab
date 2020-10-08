
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    "Article Home Page"
  end

  #articles_index
  get "/articles" do
    @articles = Article.all

    erb :index
  end

  #articles_new
  get "/articles/new" do
    erb :new
  end

  #articles_show
  get "/articles/:id" do 
    
    @article = Article.find(params[:id])
    erb :show
  end

  #articles_update
  post "/articles" do
     article = Article.create(params)

     redirect "/articles/#{article.id}"
  end

  #articles_edit
  get "/articles/:id/edit" do 
    @article = Article.find(params[:id])

    erb :edit
  end

  #article_update
  patch "/articles/:id" do 
    article = Article.find(params[:id])

    new_attributes = {
      title: params[:title],
      content: params[:content]
    }

    article.update(new_attributes)

    redirect "/articles/#{article.id}"
  end

  #article_delete
  delete "/articles/:id" do 
    article = Article.find(params[:id])

    article.delete
    redirect "/articles"
  end
end
