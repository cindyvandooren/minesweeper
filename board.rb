class Board
  def initialize(rows, cols, num_bombs)
    @num_bombs = num_bombs
    @grid = Array.new(rows) { Array.new(cols) }.populate
  end

  #Randomly put bombs on the grid
  def populate
    
  end

end
