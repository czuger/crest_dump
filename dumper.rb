require 'yaml'
require 'pp'
require 'sequel'
require_relative 'processed_lines'

unless ARGV.count == 2
  puts 'Usage : ruby dumper.rb <eve_business_server rail app path> <dev_env>'
  exit
end

config_file = ARGV[0] + '/config/database.yml'

f = File.open( config_file, 'r' )
db_config = YAML::load( f )
pl = ProcessedLines.new

database = db_config[ ARGV[1] ][ 'database' ]
pg_config = {}
pg_config[ :user ] = db_config[ ARGV[1] ][ 'username' ] if db_config[ ARGV[1] ][ 'username' ]
pg_config[ :password ] = db_config[ ARGV[1] ][ 'password' ] if db_config[ ARGV[1] ][ 'password' ]
pg_config[ :search_path ] = db_config[ ARGV[1] ][ 'schema_search_path' ] if db_config[ ARGV[1] ][ 'schema_search_path' ]

pp pg_config

DB = Sequel.postgres( database, pg_config )

fields = [ :cpp_region_id, :cpp_eve_item_id, :history_date, :order_count, :volume, :low_price, :avg_price, :high_price ]

File.open( 'crest_dump.csv', 'w' ) do |file|
  DB[ :regions ].join( :crest_price_histories, region_id: :id ).join( :eve_items, id: :eve_item_id ).
    use_cursor( hold: false ).select( *fields ).each do |row|
    row[ :history_date ] = row[ :history_date ].utc.to_i
    array = fields.map{ |e| row[ e ] }
    file.puts( array.join( ';' ) )
    pl.p( nb_lines_trigger: 100000 )
  end
end

`gzip crest_dump.csv`

`echo \`md5sum dump.csv.gz\` > dump.md5`



