class Tile
  DELTA = [
            [-1, -1],
            [-1,  0],
            [-1,  1],
            [ 0,  1],
            [ 1,  1],
            [ 1,  0],
            [ 1, -1],
            [ 0, -1]
          ]

  attr_reader :pos

  def initialize(board,pos)
    @board = board
    @position = position
    @bombed = false
    @flagged = false
    @revealed = false
  end

  def bombed?
    @bombed
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def change_flag
    @flagged = !@flagged
  end

  def reveal
    @revealed = true
  end

  def plant_bomb
    @bombed = true
  end

  def neighbors
    all = all_possible_neighbors

    all.select {|pos| on_board?(pos)}
  end

  def all_possible_neighbors
    all_possible_neighbors = []

    DELTA.each do |delta|
      all_possible_neighbors << [position[0] + delta[0], position[1] + delta[1]]
    end

    all_possible_neighbors
  end

  def on_board?(pos)
    rows = @board.size
    cols = @board[0].size

    pos[0].between?(0...rows) && pos[1].between?(0...cols)
  end

  def neighbors_bomb_count
    neighbors.select(&:bombed?).count
  end

  def inspect
    puts "pos: #{position}, revealed: #{revealed?}, bombed: #{bombed?}, flagged: #{flagged?}"
  end

  def to_s
    if flagged?
      "F"
    elsif revealed?
      num = neighbors_bomb_count
      if num > 0
        "#{num}"
      else
        "_"
      end
    else
      "*"
    end
  end
end
