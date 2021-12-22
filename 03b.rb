data = ARGF.each_line.collect {|line| line.chomp}

numBits = data[0].size
commonBits = []

curData = data
for b in 0..(numBits-1)
  if curData.size == 1
    break
  end
  bitsum = curData.collect { |x| x[b].to_i }.sum
  
  bit = (2*bitsum >= curData.size) ? 1 : 0
  curData = curData.select { |x| x[b].to_i == bit }
end

ox = curData[0].to_i(2)

curData = data
for b in 0..(numBits-1)
  if curData.size == 1
    break
  end
  bitsum = curData.collect { |x| x[b].to_i }.sum
  
  bit = (2*bitsum >= curData.size) ? 0 : 1
  curData = curData.select { |x| x[b].to_i == bit }
  
end

co2 = curData[0].to_i(2)

puts (ox * co2)