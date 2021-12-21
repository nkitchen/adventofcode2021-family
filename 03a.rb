data = ARGF.each_line.collect {|line| line.chomp}

numBits = data[0].size
commonBits = []

for b in 0..(numBits-1)
  bitsum = data.collect { |x| x[b].to_i }.sum
  
  if bitsum > data.size/2
    commonBits << 1
  else
    commonBits << 0
  end
end

c = commonBits.join("")
gamma = c.to_i(2)

epsilon = c.tr('01', '10').to_i(2)

puts gamma * epsilon