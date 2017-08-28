require "yaml"

File.open("./resources/#{ARGV[0]}") do |file|
  puts YAML.parse(file)[ARGV[1]].inspect
end
