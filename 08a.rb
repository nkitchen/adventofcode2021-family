Inst = Struct.new(:patterns, :outputs)

def main()
  insts = []
  for line in ARGF
    sides = line.split('|')
    patterns = sides[0].split
    outputs = sides[1].split
    insts << Inst[patterns, outputs]
  end

  n = 0
  for inst in insts
    for d in inst.outputs
      if [2, 3, 4, 7].include?(d.size)
        n += 1
      end
    end
  end
  puts n
end

main()