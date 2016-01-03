require 'active_record'
require 'yaml'
require 'pp'
require 'sequel'
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

database = db_config[ ARGV[1] ][ 'database' ]
pg_config = {}
pg_config[ :user ] = db_config[ ARGV[1] ][ 'username' ] if db_config[ ARGV[1] ][ 'username' ]
pg_config[ :password ] = db_config[ ARGV[1] ][ 'password' ] if db_config[ ARGV[1] ][ 'password' ]
pg_config[ :host ] = :localhost

DB = Sequel.postgres( database, pg_config )

File.open( 'dump.json_lines', 'w' ) do |file|
  DB[ :regions ].join( :crest_price_histories, region_id: :id ).join( :eve_items, id: :eve_item_id ).
    use_cursor( hold: false ).select( :cpp_region_id, :cpp_eve_item_id, :order_count, :volume, :low_price, :avg_price, :high_price ).each do |row|
    # row[ :history_date ] = row[ :history_date ].to_i
    array = row.values
    file.puts( array.join( ';' ) )
    pl.p( nb_lines_trigger: 10000 )
  end
end


# ActiveRecord::Base.establish_connection( db_config[ ARGV[1] ] )
#
# File.open( 'dump.json_lines', 'w' ) do |file|
#   CrestPriceHistory.joins( :region, :eve_item ).find_each do |row|
#     array = [ row.region.cpp_region_id, row.eve_item.cpp_eve_item_id.to_s, row.history_date.to_i, row.order_count, row.volume, row.low_price, row.avg_price, row.high_price ]
#     file.puts( array.to_json )
#     pl.p( nb_lines_trigger: 10000 )
#   end
# end


