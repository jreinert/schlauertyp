File.open("./resources/#{ARGV[0]}") do |file|
  puts file.gets_to_end.inspect
end

