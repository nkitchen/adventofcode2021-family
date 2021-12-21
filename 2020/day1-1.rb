# https://adventofcode.com/2020/day/1

require 'set'

input = "example1.txt"
numbers = File.readlines(input).map {|line| line.to_i}
numbers = numbers.to_set

numbers.each do |n|
  m = 2020 - n
  if numbers.include?(m)
    puts m * n
  end
end
#i = 0
#for i[,i] in numbers do
#  
#end