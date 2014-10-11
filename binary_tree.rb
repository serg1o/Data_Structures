class Node
  attr_accessor :value, :parent, :left_child, :right_child
  def initialize(val=nil)
    @value = val
    @parent = nil
    @left_child = nil
    @right_child = nil
  end

  def to_s
    parent_node = parent.nil? ? "none" : parent.to_s
    l_child = left_child.nil? ? "none" : left_child.value.to_s
    r_child = right_child.nil? ? "none" : right_child.value.to_s
    return "value: " + value.to_s + ", parent: " + parent_node + ", left_child: " + l_child + ", right_child: " + r_child
  end
end

class Tree
  attr_accessor :tree
  def initialize
    @tree = Node.new()
  end

  def place_in_tree(tre, node)
    if (node.value) > (tre.value)
      if tre.right_child.nil?
        node.parent = tre.value
        tre.right_child = node
      else
        place_in_tree(tre.right_child, node)
      end
    elsif node.value < tre.value
      if tre.left_child.nil?
        node.parent = tre.value
        tre.left_child = node
      else
        place_in_tree(tre.left_child, node)
      end
    else
      puts "Error: the element already exists in the tree"
    end
  end

  def build_tree
   # values = 30.times.map{rand(200) + 1}
    values = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15].shuffle
    #values = [5, 6, 14, 11, 4, 2, 9, 12, 10, 13, 8, 3, 7, 1, 15]
    puts values.inspect
    @tree.value = values.shift
    values.each do |val|
      node = Node.new(val)
      place_in_tree(@tree, node)
    end
  end

  def breadth_first_search(target)
    queue = [@tree]
    visited = [@tree.value]
    return @tree if target == @tree.value
    while !queue.empty?
      node = queue.pop
      children = [node.left_child, node.right_child]
      children.each do |next_child|
        if !next_child.nil?
          queue.unshift(next_child)
          visited.push(next_child.value)
        #  puts "bfs " + next_child.value.to_s
          return next_child if target == next_child.value
        end
      end
    end
    nil
  end

  def depth_first_search(target)
    stack = []
    visited = []
    next_node = @tree
    popped = false
    while true
      if !next_node.nil?
        return next_node if target == next_node.value
        if !popped
          stack.push(next_node)         
          visited.push(next_node.value)
        #  puts "dfs " + next_node.value.to_s
        end      
        popped = false
        if (!next_node.left_child.nil? && !visited.include?(next_node.left_child.value))
          next_node = next_node.left_child
        elsif (!next_node.right_child.nil? && !visited.include?(next_node.right_child.value))
          next_node = next_node.right_child 
        else
          return nil if stack.empty?
          next_node = stack.pop
          popped = true
        end
      end
    end
  end

  def dfs_rec(target, next_node = @tree)
    return nil if next_node.nil?
    return next_node if target == next_node.value 
  #  puts "dfs_rec " + next_node.value.to_s
    return ( dfs_rec(target, next_node.left_child) || dfs_rec(target, next_node.right_child) )
  end

  def show_tree(tre)
    return nil if tre.nil?
    puts tre.to_s
    show_tree(tre.left_child) if !tre.left_child.nil?
    show_tree(tre.right_child) if !tre.right_child.nil?
  end
  
end

arv = Tree.new
arv.build_tree
arv.show_tree(arv.tree)
x = arv.breadth_first_search(10)
(x.nil?) ? puts("\n Not found!") : puts("\n Found! " + x.to_s)
x = arv.breadth_first_search(100)
(x.nil?) ? puts("\n Not found!") : puts("\n Found! " + x.to_s)

x = arv.depth_first_search(10)
(x.nil?) ? puts("\n Not found!") : puts("\n Found! " + x.to_s)
x = arv.depth_first_search(100)
(x.nil?) ? puts("\n Not found!") : puts("\n Found! " + x.to_s)

x = arv.dfs_rec(10)
(x.nil?) ? puts("\n Not found!") : puts("\n Found! " + x.to_s)
x = arv.dfs_rec(100)
(x.nil?) ? puts("\n Not found!") : puts("\n Found! " + x.to_s)

