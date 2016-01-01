require 'active_record'
require 'yaml'
require 'pp'
require_relative 'processed_lines'

unless ARGV.count == 2
  puts 'Usage : ruby dumper.rb <eve_business_server rail app> <dev_env>'
  exit
end

config_file = ARGV[0] + '/config/database.yml'
models_path = ARGV[0] + '/app/models/'

require models_path + 'crest_price_history.rb'
require models_path + 'region.rb'
class EveItem < ActiveRecord::Base
end

f = File.open( config_file, 'r' )
db_config = YAML::load( f )
pl = ProcessedLines.new

ActiveRecord::Base.establish_connection( db_config[ ARGV[1] ] )

File.open( 'dump.json_lines', 'w' ) do |file|
  CrestPriceHistory.joins( :region, :eve_item ).find_each do |row|
    array = [ row.region.cpp_region_id, row.eve_item.cpp_eve_item_id.to_s, row.history_date.to_i, row.order_count, row.volume, row.low_price, row.avg_price, row.high_price ]
    file.puts( array.to_json )
    pl.p( nb_lines_trigger: 10000 )
  end
end
