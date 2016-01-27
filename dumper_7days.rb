require 'yaml'
require 'pp'
require 'sequel'
require_relative 'processed_lines'

unless ARGV.count == 2
  puts 'Usage : ruby dumper_7days.rb <eve_business_server rail app path> <dev_env>'
  exit
end

config_file = ARGV[0] + '/config/database.yml'

f = File.open( config_file, 'r' )
db_config = YAML::load( f )
pl = ProcessedLines.new

# Loading rails database config
database = db_config[ ARGV[1] ][ 'database' ]
pg_config = {}
pg_config[ :user ] = db_config[ ARGV[1] ][ 'username' ] if db_config[ ARGV[1] ][ 'username' ]
pg_config[ :password ] = db_config[ ARGV[1] ][ 'password' ] if db_config[ ARGV[1] ][ 'password' ]
pg_config[ :search_path ] = db_config[ ARGV[1] ][ 'schema_search_path' ] if db_config[ ARGV[1] ][ 'schema_search_path' ]

DB = Sequel.postgres( database, pg_config )

fields = [ :cpp_region_id, :cpp_eve_item_id, :history_date, :order_count, :volume, :low_price, :avg_price, :high_price ]

# Dumping crest table
dump_time = Time.now
dump_path = "dumps/crest_dump_7days_#{dump_time.to_i}.csv"
File.open( dump_path, 'w' ) do |file|
  DB[ :regions ].join( :crest_price_histories, region_id: :id ).join( :eve_items, id: :eve_item_id )
    .where( :history_date > Time.now - ( 7 * 24 * 3600 ) )
    use_cursor( hold: false ).select( *fields ).each do |row|
    row[ :history_date ] = row[ :history_date ].utc.to_i
    array = fields.map{ |e| row[ e ] }
    file.puts( array.join( ';' ) )
    pl.p( nb_lines_trigger: 100000 )
  end
end

# Zipping file
`gzip #{dump_path}`
`echo \`md5sum #{dump_path}.gz | awk '{ print $1 }'\` > #{dump_path}.md5`

# Changing symlinks
File.unlink( 'public-dump/crest_dump_7days.csv.gz' ) if File.exist?( 'public-dump/crest_dump_7days.csv.gz' )
File.unlink( 'public-dump/crest_dump_7days.csv.gz.md5' ) if File.exist?( 'public-dump/crest_dump_7days.csv.gz.md5' )

File.symlink( "../#{dump_path}.gz", 'public-dump/crest_dump_7days.csv.gz' )
File.symlink( "../#{dump_path}.md5", 'public-dump/crest_dump_7days.csv.gz.md5' )

# Removing old files
Dir.chdir( 'dumps' )
Dir.entries( '.' ).each do |entry|
  next if entry == 'keep_dir'
  if File.file?( entry )
    if File.ctime( entry ) < ( dump_time - ( 8 * 3600 ) )
      File.unlink( entry )
    end
  end
end



