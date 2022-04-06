# https://www.twilio.com/blog/2017/03/google-spreadsheets-ruby.html
# https://www.youtube.com/watch?v=VqoSUSy011I

require 'google_drive'
require 'pry'

session = GoogleDrive::Session.from_service_account_key("sec/google_service.json")

book = session.spreadsheet_by_title("tally")
state = book.worksheet_by_title('state')
links = book.worksheet_by_title('links')

state[1,1] = state[1,1].to_i + 1
state.save

puts links.rows[0].join(' | ')


# ws.rows[0..2].each do |i|
  # i.first = i.first.to_i + 1p
# end



# ws.rows[200..207].each do |i|
#   sleep 3
#   #   say -v '?'
#   # `say -v Alex '#{i.first}'`
# end
