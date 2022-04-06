# https://www.twilio.com/blog/2017/03/google-spreadsheets-ruby.html
# https://www.youtube.com/watch?v=VqoSUSy011I

require 'google_drive'
require 'pry'

session = GoogleDrive::Session.from_service_account_key("sec/google_service.json")

s = session.spreadsheet_by_title("Freshly vocab")
ws = s.worksheets.first
ws.rows[200..207].each do |i|
  sleep 3
  #   say -v '?'
  `say -v Alex '#{i.first}'`
end
