require "google/apis/sheets_v4"
require "googleauth"
require "fileutils"
require 'pry'

PERMISIONS = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
CREDS_JSON = "credentials.json"

authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(CREDS_JSON),
  scope: PERMISIONS
)

service = Google::Apis::SheetsV4::SheetsService.new
service.authorization = authorizer

# https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
SOURCE = "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
RANGE = "Class Data!A2:E"
response = service.get_spreadsheet_values(SOURCE, RANGE)

response.values.each do |row|
  puts "#{row[0]}, #{row[4]}"
end

puts "No data found." if response.values.empty?
