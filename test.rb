require 'set'
s = Set.new
s.add("foo")
s.add("bar")
puts s.include?("bar")