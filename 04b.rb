require 'set'

$drawn = Hash.new

def main()
  draws, boards = readGame()

  for x in draws
    $drawn[x] = 1
    won_boards = boards.select { |b| won?(b) }
    
    won_boards.each do |b|
      boards.delete(b)
    end

    if boards.empty?
      score = unmarkedSum(won_boards[0]) * x
      puts score
      return
    end
  end
end

def unmarkedSum(board)
  return (Set.new(board.flatten) - Set.new($drawn.keys)).sum
end

def won?(board)
  for i in 0..4
    s = 0
    for j in 0..4
      s += $drawn.fetch(board[i][j], 0)
    end
    if s == 5
      return true
    end
  end

  for j in 0..4
    s = 0
    for i in 0..4
      s += $drawn.fetch(board[i][j], 0)
    end
    if s == 5
      return true
    end
  end

  return false
end

def readGame()
  drawLine = ARGF.gets
  draws = drawLine.split(',').collect {|x| x.to_i}

  boards = []
  while !ARGF.eof?
    # Blank
    ARGF.gets

    board = []
    for i in 1..5
      board << ARGF.gets.split.collect {|x| x.to_i}
    end
    boards << board
  end

  return draws, boards
end

main()