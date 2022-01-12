require 'scanf'

Point = Struct.new(:x, :y)

$DEBUG = false

def main()
  segments = readSegments()

  map = Hash.new
  map.default = 0
  
  for seg in segments
    for p in segmentPoints(*seg)
      map[p] += 1
    end
  end

  if $DEBUG
    xMax = map.keys.collect { |p| p.x }.max
    yMax = map.keys.collect { |p| p.y }.max
    for y in 0..yMax
      for x in 0..xMax
        n = map[Point[x,y]]
        if n == 0
          print "."
        else
          print n
        end
      end
      puts
    end
  end

  puts map.count { |p, n| n >= 2 }
  
end

def readSegments()
  segments = []
  for line in ARGF
    x1, y1, x2, y2 = line.scanf("%d,%d -> %d,%d")
    segments << [Point[x1, y1], Point[x2, y2]]
  end
  return segments
end

def range(a, b)
  case
  when a < b
    by = 1
  when a > b
    by = -1
  end
  return a.step(b, by)
end

def segmentPoints(p, q)
  case
  when p.x == q.x
    return range(p.y, q.y).collect { |y| Point[p.x, y] }
  when p.y == q.y
    return range(p.x, q.x).collect { |x| Point[x, p.y] }
  else
    pairs = range(p.x, q.x).zip(range(p.y, q.y))
    return pairs.collect{ |x, y| Point[x, y] }
  end  
end

main()