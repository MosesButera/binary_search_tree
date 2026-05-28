# frozen_string_lateral: true

require_relative 'node'

class Tree
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
end
