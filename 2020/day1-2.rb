# https://adventofcode.com/2020/day/1

require 'set'

input = "input1.txt"
numbers = File.readlines(ARGV[0]).map {|line| line.to_i}
numbers = numbers.to_set

def solve(numbers)
  numbers.each do |x|
    numbers.each do |y|
      numbers.each do |z|
        if x + y + z == 2020
          return x * y * z       
        end
      end
    end
  end
end

puts solve(numbers)