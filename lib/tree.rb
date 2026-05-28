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

    puts "start: #{start}, ending: #{ending}, mid_index: #{mid}"
    node.left_child = build_tree(start, mid - 1)
    puts "start: #{start}, ending: #{ending}, mid: #{mid}"
    node.right_child = build_tree(mid + 1, ending)

    node
  end
end
