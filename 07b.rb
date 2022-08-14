def main()
  $crabs = ARGF.gets.split(',').collect {|x| x.to_i}
  
  $crabs.sort!
  
  s = $crabs.sum
  n = $crabs.size

  def fuel(p)
    f = 0
    $crabs.each do |c|
      d = (c - p).abs
      f += (d * (d+1)) / 2
    end
    return f
  end
  
  opts = []
  (0..(n-2)).each do |i|
    x = (s + n/2 - i) / n
    cp = $crabs[i]
    cn = $crabs[i+1]
    if cp <= x && x <= cn
      # x may have been rounded down, so try x + 1, too.
      opts << fuel(x)
      opts << fuel(x + 1)
    end
  end

  puts opts.to_s
  puts opts.min
end

main()

# Let c1 < c2 < ... < c_n be the crab positions.
# f(x) is the fuel cost for an alignment position of x.
# The individual cost for one crab ci is:
#     sum(k, k=1,...,|x-ci|)
#   = |x-ci| * (|x-ci| + 1) / 2
#
# The sum f(x) is a piecewise quadratic.
# For ci <= x <= c{i+1},
#     f(x) = sum((x-ck)**2 / 2, k=1,...,n)
#            + sum((x-ck)/2, k=1,...,i)
#            + sum((ck-x)/2, k=i+1,...,n)
#
# The value of x that minimizes this is not affected by the factor of 1/2, so I
# can drop it.
#
# d/dx f(x) = sum(2*(x-ck), k=1,...,n)
#             + i
#             - (n - i)
#           = 2*n*x - 2*sum(ck, k=1,...,n) + 2*i - n
#           = 0
#
# x = (sum(ck, k=1,...,n) + n/2 - i) / n

# 1 2 4 16

# S=23
# i=1 (23+2-1)/4=6 ! <= 2
# i=2 (23+2-2)/4=23/4 ! <= 2
# i=3 (23+2-3)/4=11/2 ; 4 <= 5.5 <= 16