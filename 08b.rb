require 'set'

Inst = Struct.new(:patterns, :outputs)

$DEBUG = !true
def dputs(x)
  if $DEBUG
    puts x
  end
end

def main()
  insts = []
  for line in ARGF
    sides = line.split('|')
    patterns = sides[0].split
    outputs = sides[1].split
    insts << Inst[patterns, outputs]
  end

  s = 0
  for inst in insts
    v = decode(inst)
    dputs v
    s += v
  end
  puts s
end

def decode(inst)
  # 2 segments ==> s1 (CF)
  # 3 segments ==> s7 (ACF)
  # 4 segments ==> s4 (BCDF)
  # 7 segments ==> s8 (ABCDEFG)
  # s7 - s1 ==> A
  # 6 segments, overlaps with S1 in 1 segment ==> F, s6
  # s1 - F ==> C
  # size 5, no C ==> s5
  # s6 - s5 ==> E
  # size 5, includes E ==> s2
  # size 5, does not include E ==> s3
  # size 6, does not include E ==> s9  
  # size 6, not s6 or s9 ==> s0

  digitsBySize = Hash.new { |h,k| h[k] = [] }
  for p in inst.patterns
    digitsBySize[p.size] << Set.new(p.chars)
  end

  sd = {}
  sd[1] = digitsBySize[2][0]
  sd[7] = digitsBySize[3][0]
  sd[4] = digitsBySize[4][0]
  sd[8] = digitsBySize[7][0]

  sA = sd[7] - sd[1]
  sd[6] = nil
  sF = nil
  for s in digitsBySize[6]
    overlap = s & sd[1]
    if overlap.size == 1
      sd[6] = s
      sF = overlap
      break
    end
  end
  sC = sd[1] - sF
  digitsBySize[6].delete(sd[6])

  sd[5] = digitsBySize[5].select {|s| !s.intersect?(sC)}.to_a[0]
  sE = sd[6] - sd[5]
  digitsBySize[5].delete(sd[5])
  sd[2] = digitsBySize[5].select {|s| s.intersect?(sE)}.to_a[0]
  sd[3] = digitsBySize[5].select {|s| !s.intersect?(sE)}.to_a[0]

  sd[9] = digitsBySize[6].select {|s| !s.intersect?(sE)}.to_a[0]
  digitsBySize[6].delete(sd[9])
  sd[0] = digitsBySize[6][0]
  dputs sd

  digitValue = {}
  sd.each_pair do |n, s|
    digitValue[s] = n
  end
  dputs digitValue.to_s

  v = 0
  for p in inst.outputs
    dputs p
    v = v * 10 + digitValue[Set.new(p.chars)]
  end
  return v
end

main()