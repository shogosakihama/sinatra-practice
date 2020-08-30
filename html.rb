
def hello
  puts "<h1>こんにちは！</h1>"
end

def hey
  puts "<h1>ヤッホー！</h1>"
end

print "リクエスト: "
request = gets.chomp

if request == "hello"
  hello
elsif request == "hey"
  hey
end