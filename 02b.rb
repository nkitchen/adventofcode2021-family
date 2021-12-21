hPos = 0
depth = 0
aim = 0

ARGF.each do |line|
  dir, units = line.split
  units = units.to_i

  case dir
  when "forward"
    hPos += units
    depth += aim * units
  when "up"
    aim -= units
  when "down"
    aim += units
  end
end

puts hPos * depth