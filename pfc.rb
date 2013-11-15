require 'Thin'

rackup_file = "config.ru" 

argv = ARGV

argv << ["-R", rackup_file ] unless ARGV.include?("-R")
#argv << ["-e", "production"] unless ARGV.include?("-e")

Thin::Runner.new(argv.flatten).run!
