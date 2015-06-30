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

  attr_reader :position

  def initialize(board, position, bombed=false)
    @board = board
    @position = position
    @bombed = bombed
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

  #Only change the flag if the tile has not yet been revealed
  def change_flag
    @flagged = !@flagged unless revealed?
  end

  #This is used to reveal the board at the end of the game.
  #In order to reveal all of the bombs we cannot reveal the flags.
  def unflag
    @flagged = false
  end

  def reveal
    @revealed = true
  end

  def plant_bomb
    @bombed = true
  end

  def neighbors
    valid_neighbours = all_possible_neighbors.select { |pos| on_board?(pos)}

    # Make sure we return the tiles and not only the positions
    valid_neighbours.map{ |pos| @board[*pos] }
  end

  def all_possible_neighbors
    all_possible_neighbors = []

    DELTA.each do |delta|
      all_possible_neighbors << [position[0] + delta[0], position[1] + delta[1]]
    end

    all_possible_neighbors
  end

  def on_board?(pos)
    rows = @board.rows
    cols = @board.cols

    pos[0].between?(0, rows - 1) && pos[1].between?(0, cols - 1)
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
      if bombed?
        "B"
      elsif num > 0
        "#{num}"
      else
        "_"
      end
    else
      "*"
    end
  end
end
