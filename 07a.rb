def main()
  input = ARGF.gets.split(',').collect {|x| x.to_i}
  
  input.sort!

  length = input.size
  p = input[length/2]
  puts p
  
  fuel = input.collect { |x| (x - p).abs }.sum
  puts fuel
end

main()