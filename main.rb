# frozen_string_lateral: true

require_relative 'lib/node'
require_relative 'lib/tree'

list = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 5000, 9000, 9001, 9002, 9003, 9004]

tree = Tree.new(list)

tree.pretty_print
puts tree.include?(1)
root = tree.root
puts "current list: #{list}"

puts 'INSERTING 700'
tree.insert(root, 700)
tree.pretty_print

puts 'DELETING 6345'
tree.delete_node(root, 6345)
tree.pretty_print
puts 'DELETING 1'
tree.delete_node(root, 1)
tree.pretty_print

# test level_order
puts "\nprinting level_order iterative traversal:"
tree.level_order { |node_value| puts node_value }

tree.pretty_print
# test recursive implementation
puts "\nprinting level_order recursive traversal:"
tree.level_order_recursive { |data| print "#{data} " }

# test in_order
puts "\nprinting in_order traversal:"
tree.in_order { |data| print "#{data} " }

# test pre_order
puts "\nprinting pre_order traversal:"
tree.pre_order { |data| print "#{data} " }

# test post_order
puts "\nprinting post_order traversal:"
tree.post_order { |data| print "#{data} " }

puts 'testing left-heavy (testing get_left_count)'
list_1 = [10, 20, 30, 40, 50, 60, 70]
tree_1 = Tree.new(list_1, balanced: false)
tree_1.height(40)
puts "HEIGHT of 40: #{tree_1.height(40)}"
tree_1.pretty_print

puts 'Example 2: The Right-Heavy Subtree (Testing get_right_count)'
list_2 = [5, 10, 15, 20, 25, 30, 35]
tree_2 = Tree.new(list_2, balanced: false)
tree_2.height(20)
puts "HEIGHT of 20: #{tree_2.height(20)}"
tree_2.pretty_print

puts 'Example 3: Leaf Node Edge Case (Testing 0 count thresholds)'
list_3 = [1, 3, 5]
tree_3 = Tree.new(list_3, balanced: false)
tree_3.height(5)
puts "HEIGHT of 5: #{tree_3.height(5)}"
tree_3.pretty_print

puts 'Example 4: Large Unbalanced Sub-branch Simulation'
list_4 = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150]
tree_4 = Tree.new(list_4, balanced: false)
tree_4.height(80)
puts "HEIGHT of 80: #{tree_4.height(80)}"
tree_4.pretty_print

puts '(Testing the nil crash behavior)'
list_5 = [2, 4, 6, 8]
tree_5 = Tree.new(list_5, balanced: false)
puts tree_5.height(5).inspect
tree_5.pretty_print

puts 'Test Case 1: The Multi-Zigzag Spine. True Height: 4'
list_6 = [50, 40, 45, 42, 43]
tree_6 = Tree.new(list_6, balanced: false)
tree_6.height(50)
puts "HEIGHT of 50: #{tree_6.height(50)}"
tree_6.pretty_print

puts 'Test Case 2: The Perfect Left-Skewed Broom. True Height: 3'
list_7 = [100, 80, 60, 70]
tree_7 = Tree.new(list_7, balanced: false)
tree_7.height(100)
puts "HEIGHT of 100: #{tree_7.height(100)}"
tree_7.pretty_print

puts 'Test Case 3: The Sibling Disparity. True Height: 4'
list_8 = [10, 5, 20, 30, 40, 50]
tree_8 = Tree.new(list_8, balanced: false)
tree_8.height(10)
puts "HEIGHT of 10: #{tree_8.height(10)}"
tree_8.pretty_print

puts 'Test Case 4: Deep Internal Node Search True Height: 3'
list_9 = [50, 15, 80, 30, 25, 40, 45, 48]
tree_9 = Tree.new(list_9, balanced: false)
tree_9.height(30)
puts "HEIGHT of 30: #{tree_9.height(30)}"
tree_9.pretty_print

puts '============================================================'
puts 'TESTING DEPTH'
puts 'Test Case 1: Searching for the Root Node (Depth = 0 Boundary)'
list_10 = [10, 5, 15]
tree_10 = Tree.new(list_10, balanced: false)
tree_10.depth(10)
puts "DEPTH of 10: #{tree_10.depth(10)}"
tree_10.pretty_print

puts 'Test Case 2: Deeply Nested Leaf Node (True Depth: 3)'
list_11 = [10, 20, 30, 40]
tree_11 = Tree.new(list_11, balanced: false)
tree_11.depth(40)
puts "DEPTH of 40: #{tree_11.depth(40)}"
tree_10.pretty_print

puts 'Test Case 3: Value That Is Not Present in the Tree (True Depth: nil)'
list_12 = [5, 3, 8]
tree_12 = Tree.new(list_12)
puts "Should return nil: #{tree_12.depth(99).inspect}"
tree_10.pretty_print

puts 'Test Case 4: True Depth: 1'
list_13 = [50, 20, 10, 5, 80]
tree_13 = Tree.new(list_13, balanced: false)
tree_13.depth(80)
puts "DEPTH Of 80: #{tree_13.depth(80)}"
tree_10.pretty_print

puts '============================================================'
puts 'TESTING BALANCE'
puts 'Test Case 1: The Perfectly Balanced Tree (The Success Benchmark)- True Status: true'
list_14 = [20, 10, 30, 5, 15, 25, 35]
tree_14 = Tree.new(list_14)
tree_14.is_balanced?
puts "BALANCED?: #{tree_14.is_balanced?}"
tree_14.pretty_print

puts 'Test Case 2: The Acceptable Asymmetric Tree (The Boundary Limit) - True Status: true'
list_15 = [50, 25, 75, 12]
tree_15 = Tree.new(list_15)
tree_15.is_balanced?
puts "BALANCED?: #{tree_15.is_balanced?}"
tree_15.pretty_print

puts 'Test Case 3: The Isolated Subtree Tilt (The Deep Detection Trap)- True Status: false (unbalanced)'
list_16 = [100, 50, 150, 25, 175, 12, 200, 6]
tree_16 = Tree.new(list_16, balanced: false)
balance = tree_16.is_balanced?
puts "BALANCED?: #{balance}"
tree_16.pretty_print

puts 'Test Case 4: The Extreme Linear Skew (The Worst-Case Scenario)'
list_17 = [10, 20, 30, 40]
tree_17 = Tree.new(list_17, balanced: false)
tree_17.is_balanced?
puts "BALANCED?: #{tree_17.is_balanced?}"
tree_17.pretty_print

puts '============================================================'
puts 'TESTING BALANCE'

puts 'tree before rebalance'
tree_16.pretty_print
tree_16.rebalance
puts 'tree after rebalance'
tree_16.pretty_print

puts '============================================================'
puts 'TESTING SCRIPT'

list_17 = Array.new(15) { rand(1..100) }
puts "Array = #{list_17}"
tree_17 = Tree.new(list_17)
tree_17.driver_script
