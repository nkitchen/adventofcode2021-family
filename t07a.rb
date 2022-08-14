def main()
  input = ARGF.gets.split(',').collect {|x| x.to_i}
  
  input.sort!

  puts input.sum / input.size
end

main()