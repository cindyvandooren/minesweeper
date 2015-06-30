require_relative 'tile'
require 'byebug'

class Board
  attr_reader :num_bombs

  def initialize(rows, cols, num_bombs)
    @num_bombs = num_bombs
    @grid = Array.new(rows) { Array.new(cols) }
    populate
  end

  def [](row, col)
    @grid[row][col]
  end

  def []= (row, col, value)
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

    until bomb_pos.count == num_bombs
      rand_pos = [rand(rows - 1), rand(cols - 1)]
      bomb_pos << rand_pos unless bomb_pos.include?(rand_pos)
    end

    bomb_pos
  end

  #Puts bombs and regular tiles on the grid
  def populate
    bomb_pos = calculate_bomb_pos
    # debugger
    (0...rows).each do |row|
      (0...cols).each do |col|
        pos = [row, col]
        if bomb_pos.include?(pos)
          self[*pos] = Tile.new(self, pos, true)
        else
          self[*pos] = Tile.new(self, pos)
        end
      end
    end
  end

  def render
    puts "  #{(0...rows).to_a.join(" ")}"
    (0...rows).each do |row|
      puts "#{row} #{@grid[row].to_a.join(" ")}"
    end
  end

  def reveal
  end

  #Reveals all tiles, including the bombs
  def reveal_all
    (0...rows).each do |row|
      (0...cols).each do |col|
        pos = [row, col]
        self[*pos].unflag
        self[*pos].reveal
      end
    end
  end
end

a = Board.new(9, 9, 10)
a.render
a.reveal_all
puts
a.render
