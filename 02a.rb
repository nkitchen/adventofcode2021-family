hPos = 0
depth = 0

ARGF.each do |line|
  dir, units = line.split
  units = units.to_i

  case dir
  when "forward"
    hPos += units
  when "up"
    depth -= units
  when "down"
    depth += units
  end
end

puts hPos * depth