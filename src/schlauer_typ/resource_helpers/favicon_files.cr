files = Dir["./resources/favicon*"].map do |file|
  File.basename(file)
end

puts files.inspect
