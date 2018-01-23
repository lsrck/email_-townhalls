require "gmail"
require "dotenv"
Dotenv.load

#log avec .env
gmail = Gmail.connect!(ENV["USERNAME"], ENV["PASSWORD"])

gmail.deliver do
  to "jmblintest@gmail.com"
  subject "Test Thp"
  text_part do
    body "Test N°1"
  end
#  html_part do
#   content_type 'text/html; charset=UTF-8'
#   body "<p>Text of <em>html</em> message.</p>"
end

gmail.logout