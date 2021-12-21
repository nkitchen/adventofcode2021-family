input = ARGV[0]
data = File.readlines(input).map {|line| line.to_i}

def countIncreases(list)
  counter = 0

  for i in 1...list.size do
    if list[i] > list[i - 1]
      counter += 1
    end
  end
  return counter
end

def windowed(list)
  r = []
  for i in 0..(list.size - 2) do
    r << list[i, 3].sum
  end
  return r
end


puts countIncreases(windowed(data))