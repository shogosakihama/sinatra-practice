
require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'
require 'sinatra/cookies'

enable :sessions


# get "/hello" do
#   puts "<h1>こんにちは！</h1>"
# end



get '/posts/new' do
  return erb :new_post
end


post '/posts' do
  @title = params[:title]
  @content = params[:content]
  if !params[:img].nil?
    tempfile = params[:img][:tempfile]
    save_to = "./public/images/#{params[:img][:filename]}"
    FileUtils.mv(tempfile, save_to)
    @img_name = params[:img][:filename]
  end
  return erb :post
end


get '/blogs/new' do
  return erb :new_blog
end

post '/blogs' do
  @title = params[:title]
  @content = params[:content]
  return erb :blog
end


# cookkie


get "/signin" do
  return erb :signin
end

post "/signin" do
  session[:user]
  session[:user] = params[:name]
  redirect '/mypage'
end

get "/mypage" do
  @name = session[:user]
  return erb :mypage
end

delete '/logout' do
  session[:user] = nil
  redirect '/signin'
end

get '/logout' do
  session[:user] = nil
  redirect '/signin'
end


