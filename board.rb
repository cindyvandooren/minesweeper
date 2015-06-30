class Board
  def initialize(rows, cols, num_bombs)
    @num_bombs = num_bombs
    @grid = Array.new(rows) { Array.new(cols) }.populate
    populate
  end

  def [](row, col)
    x, y = pos
    @grid[row][col]
  end

  def []= (row, col, value)
    x, y = pos
    @grid[row][col] = value
  end

  def rows
    @grid.size
  end

  def cols
    @grid[0].size
  end

  #Randomly chooses the positions for the bombs
  def calculate_bomb_pos
    bomb_pos = []

    until bom_pos.count == num_bombs
      rand_pos = [rand(rows - 1), rand(cols - 1)]
      bomb_pos << rand_pos unless bomb_pos.include?(rand_pos)
    end

    bomb_pos
  end

  #Puts bombs and regular tiles on the grid
  def populate
    bomb_pos = calculate_bomb_pos

    (0...rows).each do |row|
      (0...cols).each do |col|
        pos = [row, col]
        if bomb_pos.include?(pos)
          @grid[pos] = Tile.new(self, pos, true)
        else
          @grid[pos] = Tile.new(self, pos)
        end
      end
    end
  end

  def render
  end

  def reveal
  end

  def reveal_all
  end
end
