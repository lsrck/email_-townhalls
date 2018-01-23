require "google_drive"
require "gmail"
require "json"
require "dotenv"
Dotenv.load


$gmail = Gmail.connect!(ENV["USERNAME"],ENV["PASSWORD"])


def send_email_to_line
p $gmail.inbox.count
p $gmail.inbox.count(:unread)
p $gmail.inbox.count(:read)
end

send_email_to_line
gmail.logout