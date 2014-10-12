class Square
  attr_accessor :x, :y, :connections

  def initialize(x, y)
    @x = x
    @y = y
    @connections = []
  end
end

class Board
  attr_accessor :squares, :hypo_moves

  def initialize
    @squares = []
    (0..7).each do |y|
      @squares.push([])
      (0..7).each { |x| @squares[y].push(Square.new(x,y)) }
    end
    @hypo_moves = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
    build_graph
  end
  
  def build_graph
    (0..7).each do |y|
      (0..7).each do |x|
        @hypo_moves.each do |sq|
          squares[x][y].connections.push([x + sq[0], y + sq[1]]) if (((x + sq[0]).between?(0,7) && (y + sq[1]).between?(0,7)))
        end
      end
    end
  end

  def breadth_first_search(origin, target)
    return nil if origin == target
    queue = [origin] 
    came_from = Hash.new #hash to store the path from origin to target in the form of 'key' came from 'value'
    while !queue.empty?
      square_coord = queue.pop
      children = squares[square_coord[0]][square_coord[1]].connections
      children.each do |next_child|
        queue.unshift(next_child)
        came_from[next_child] = square_coord if !came_from.has_key?(next_child)
        return came_from if ((target[0] == next_child[0]) && (target[1] == next_child[1]))
      end
    end
  end

  def knight_moves(from, to)
    return [from] if from == to
    paths = breadth_first_search(from, to)
    shortest_path = [to]
    back_step = paths[to]
    while (back_step != from)
      shortest_path.unshift(back_step)
      back_step = paths[back_step]
    end
    return shortest_path.unshift(from)
  end

end

def show_moves(moves)
  puts "\nGoing from #{moves.first} to #{moves.last}." 
  puts "You made it in #{moves.count - 1} moves!  Here's your path:\n"
  moves.each do |m|
    print "#{m}"
    print " -> " unless m == moves.last
  end
  puts
end

c = Board.new

show_moves(c.knight_moves([0,0], [3,3]))
show_moves(c.knight_moves([0,0], [1,2]))
show_moves(c.knight_moves([3,3], [0,0]))
show_moves(c.knight_moves([3,3], [4,3]))
show_moves(c.knight_moves([0,5], [6,6]))
show_moves(c.knight_moves([0,0], [7,7]))
show_moves(c.knight_moves([4,4], [3,3]))
show_moves(c.knight_moves([1,6], [6,1]))
show_moves(c.knight_moves([3,3], [7,6]))
show_moves(c.knight_moves([1,0], [6,0]))

#moves_count = []
#(0..7).each do |x1|
#  (0..7).each do |y1|
#    (0..7).each do |x2|
#      (0..7).each do |y2|
#        path = c.knight_moves([x1,y1],[x2,y2])
#        moves_count.push(path.count)
#      end
#    end
#  end
#end

#puts "\n It takes a maximum of #{moves_count.max - 1} moves for a knight to move between any two squares on a chess board."
