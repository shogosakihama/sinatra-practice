
require 'sinatra'
require 'sinatra/reloader'
# require 'fileutils'
require 'sinatra/cookies'


require 'pg'

client = PG::connect(
  :host => "localhost",
  :user => ENV.fetch("USER", "shogo_sakihama"), :password => '',
  :dbname => "postgres")


enable :sessions




get '/signup' do
  return erb :signup
end

post '/signup' do
  name = params[:name]
  email = params[:email]
  password = params[:password]
  client.exec_params("INSERT INTO users (name, email, password) VALUES ($1, $2, $3)", [name, email, password])
  user = client.exec_params("SELECT * from users WHERE email = $1 AND password = $2", [email, password]).to_a.first
  session[:user] = user
  return redirect '/mypage'
end

get "/mypage" do
  @name = session[:user]['name'] # 書き換える
  return erb :mypage
end



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



get '/signin' do
  return erb :signin
end

post '/signin' do
  email = params[:email]
  password = params[:password]
  user = client.exec_params("SELECT * FROM users WHERE email = '#{email}' AND password = '#{password}'").to_a.first
  if user.nil?
    return erb :signin
  else
    session[:user] = user
    return redirect '/mypage'
  end
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


