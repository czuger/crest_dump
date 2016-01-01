class ProcessedLines

  def initialize
    @start_time = Time.now.to_i
    @nb_lines = 0
  end

  def p( nb_lines_trigger: 1000 )
    @nb_lines += 1
    if @nb_lines % nb_lines_trigger == 0
      nb_seconds = Time.now.to_i - @start_time
      lines_seconds = nb_seconds > 0 ? @nb_lines.to_f / nb_seconds.to_f : 0
      puts "#{@nb_lines} items processed in #{nb_seconds} second. #{lines_seconds.round(2)} items/seconds"
    end
  end

end