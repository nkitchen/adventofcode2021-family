input = ARGV[0]
data = File.readlines(input).map {|line| line.to_i}

counter = 0

for i in 1...data.size do
  if data[i] > data[i - 1]
    counter += 1
  end
end

puts counter