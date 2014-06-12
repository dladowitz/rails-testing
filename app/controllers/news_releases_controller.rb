class NewsReleasesController < ApplicationController
  def index
    @news_releases = NewsRelease.all
  end

  def show
  end

  def new
    @news_release = NewsRelease.new
  end

  def create
    @news_release = NewsRelease.create(news_release_params)
    redirect_to news_releases_path
  end

  private
  # def user_params
  #   params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
  # end

  def news_release_params
    params.require(:news_release).permit(:title, :body)
  end
end
