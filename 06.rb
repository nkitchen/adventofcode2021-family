def main()
  input = ARGF.gets.split(',').collect {|x| x.to_i}
  
  timers = Hash.new(0)
  
  for fish in input
    timers[fish] += 1
  end

  for day in 1..256
    new_timers = Hash.new(0)
    timers.each_pair do |t, n|
      if t == 0
        new_timers[6] += n
        new_timers[8] += n
      else
        new_timers[t-1] += n
      end
    end
    timers = new_timers
  end

  puts timers.values.sum
end

main()