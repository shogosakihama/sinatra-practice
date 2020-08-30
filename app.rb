
require 'sinatra'
require 'sinatra/reloader'


# get "/hello" do
#   puts "<h1>こんにちは！</h1>"
# end

get "/hello" do
  return erb :html
end

get "/mypage/:name" do
  # @menu = params[:menu].split("と") # コメントアウト
  return erb :mypage
end