# frozen_string_lateral: true

require_relative 'node'

class Tree
  attr_accessor :root, :list

  def initialize(list)
    @list = list.uniq.sort
    @root = build_tree(0, @list.length - 1)
  end

  # private

  def build_tree(start, ending)
    # Base case:
    return nil if start > ending

    mid = start + ((ending - start) / 2)
    node = Node.new(@list[mid])

    node.left_child = build_tree(start, mid - 1)
    node.right_child = build_tree(mid + 1, ending)

    node
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return if node.nil?

    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def include?(value)
    @list.include?(value)
  end

  def insert(root, value)
    nil if @list.include?(value)
    return root = Node.new(value) if root.nil?

    puts "current node: #{root.data}"
    if value < root.data
      root.left_child = insert(root.left_child, value)
    else
      root.right_child = insert(root.right_child, value)
    end

    root
  end

  def get_successor(current_node)
    current_node = current_node.right_child

    current_node = current_node.left_child while !current_node.nil? && !current_node.left_child.nil?
    current_node
  end

  def delete_node(root, value)
    return nil if root.nil?
    return nil unless @list.include?(value)

    if value < root.data
      root.left_child = delete_node(root.left_child, value)
    elsif value > root.data
      root.right_child = delete_node(root.right_child, value)
    elsif root.left_child.nil?
      return root.right_child
    elsif root.right_child.nil?
      return root.left_child
    else
      successor = get_successor(root)
      root.data = successor.data
      root.right_child = delete_node(root.right_child, successor.data)
    end

    root
  end

  def level_order
    return self if @root.nil?
    return to_enum(:level_order) unless block_given?

    # Fix state corruption and memory leaks by using fresh, local queue
    # for this run
    queue = [@root]

    until queue.empty?
      current = queue.shift
      yield(current.data)

      queue.push(current.left_child) unless current.left_child.nil?
      queue.push(current.right_child) unless current.right_child.nil?
    end

    # Return self to allow for method chaining
    self
  end

  def level_order_recursive(&block)
    return to_enum(:level_order_recursive) unless block_given?
    return self if @root.nil?

    # Fresh queue initialized on every unique call
    @queue = [@root]

    # call the recursive engine
    run_level_order(&block)

    # clear the queue to free memory
    @queue = nil

    self
  end

  def run_level_order(&block)
    return if @queue.empty?

    current = @queue.shift
    yield(current.data)
    @queue << current.left_child unless current.left_child.nil?
    @queue << current.right_child unless current.right_child.nil?

    # Forward the block down to the next recursive step
    run_level_order(&block)
  end

  def in_order(node = @root, &block)
    return to_enum(:in_order) unless block_given?
    return self if node.nil?

    in_order(node.left_child, &block)
    yield(node.data)
    in_order(node.right_child, &block)

    self
  end
end
