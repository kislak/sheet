require "google/apis/sheets_v4"
require "googleauth"
require "fileutils"
require 'pry'

# PERMISIONS = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
PERMISIONS = Google::Apis::SheetsV4::AUTH_SPREADSHEETS
CREDS_JSON = "sec/google_service.json"

authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(CREDS_JSON),
  scope: PERMISIONS
)

service = Google::Apis::SheetsV4::SheetsService.new
service.authorization = authorizer

# https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
#

"https://docs.google.com/spreadsheets/d/1L60GiPM2Tu3arPkZwCRKkSdfCuIty9QmPUzXp8pbAfk/edit?usp=sharing"

# SOURCE = "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
# RANGE = "Class Data!A2:E"

SOURCE = "1L60GiPM2Tu3arPkZwCRKkSdfCuIty9QmPUzXp8pbAfk"
RANGE = "fr!A1:C100"

response = service.get_spreadsheet_values(SOURCE, RANGE)

response.values.map do |row|
  next if row.first.empty?
  puts row.join("\n  ")
end

# row = response.values.sample
# puts row.join("\n  ")

puts "No data found." if response.values.empty?



value_range_object = {
    major_dimension: "ROWS",
    values: [
        ["Timestamp", "Rand"],
        [Time.now.to_s, rand],
    ]
}

range = "fr!E1:F2"

update_res = service.update_spreadsheet_value(SOURCE, range, value_range_object, value_input_option: 'USER_ENTERED')
