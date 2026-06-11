# Binary Search Tree

A Ruby implementation of a balanced Binary Search Tree (BST) built as part of The Odin Project.

This project explores recursive tree construction, tree traversal algorithms, node insertion and deletion, balance checking, and tree rebalancing. The primary goal was to develop a deeper understanding of recursion, hierarchical data structures, and the tradeoffs involved in maintaining efficient search performance.

---

## Overview

This project implements a balanced Binary Search Tree (BST) from scratch in Ruby.

The goal was to explore how tree-based data structures organize data more efficiently than arrays for certain operations. By maintaining ordering relationships between nodes, a balanced BST can perform searches, insertions, and deletions in $O(\log n)$ time.

Through this project, I implemented tree construction, traversal algorithms, node insertion and deletion, balance checking, and tree rebalancing while gaining hands-on experience with recursion and recursive data structures.

---

## Features

* **Balanced Construction:** Builds a balanced BST from an unsorted array.
* **Data Sanitization:** Removes duplicate values automatically during initialization.
* **Optimized Lookups:** Searches for values efficiently using BST properties.
* **Dynamic Mutation:** Inserts new values while preserving tree structure.
* **Resilient Deletion:** Seamlessly handles all node deletion edge cases:
  * Leaf nodes
  * Nodes with one child
  * Nodes with two children
* **Multi-Strategy Traversals:** Walks the tree using structural paths:
  * Level Order (Breadth-First Search)
  * In Order
  * Pre Order
  * Post Order
* **Structural Metrics:** Calculates node height and node depth.
* **Balance Verification:** Determines whether the tree is currently balanced.
* **Self-Rebalancing:** Restores structural symmetry to an unbalanced tree.
* **Terminal Visualization:** Visualizes the tree directly in the console using `pretty_print`.

---

## Project Structure

```text
binary_search_tree/
├── lib/
│   ├── node.rb       # Node class: holds data and child pointers
│   └── tree.rb       # Tree class: handles all balancing, mutation, and traversal logic
└── main.rb           # Driver script orchestrating structural demonstrations
```

---

## Architecture

### Node

Represents a single node within the tree ecosystem.

```text
Node
├── data
├── left_child
└── right_child
```

### Tree

An orchestrator class responsible for:
* Building and maintaining the BST
* Managing node relationships
* Performing searches
* Traversing the tree
* Handling insertions and deletions
* Measuring balance and tree metrics
* Rebuilding unbalanced trees

### Example Tree Structure

```text
          8
        /   \
       4     67
      / \    / \
     1   5  23 324
```

Each node stores a value along with references to its left and right children. The tree preserves the strict Binary Search Tree structural invariant:

```text
Left Subtree < Parent < Right Subtree
```

---

## Core Algorithms

### Build Tree
Creates a balanced BST from a sorted array by repeatedly selecting the middle element as the root of each subtree.
* **Problem Solved:** Builds a tree that starts balanced rather than gradually becoming skewed.
* **Pattern:** **Divide → Build → Connect**
* **Key Insight:** The algorithm repeatedly chooses the middle value of a sorted array as the subtree root. Each recursive call builds a smaller subtree, and during stack unwinding the returned subtree roots are connected back to their parent nodes, producing a balanced tree.

### Insert
Traverses the tree using BST ordering rules until an empty position is found.
* **Problem Solved:** Add a new value while preserving BST properties.
* **Pattern:** **Search → Create → Reconnect**
* **Key Insight:** The new node is created at the base case when an empty position is found. As recursive calls return, each parent reconnects to the updated subtree, preserving the overall tree structure.

### Delete
Locates a target node and removes it while preserving BST structure.
* **Problem Solved:** Safely remove values without breaking parent-child relationships.
* **Pattern:** **Search → Repair → Reconnect**
* **Key Insight:** Deletion becomes a subtree replacement problem. Whether removing a leaf node, bypassing a single child, or replacing a node with its in-order successor, recursive returns reconnect the repaired subtree back into the larger tree during stack unwinding.

### Tree Traversals
Visit nodes in a specific order to inspect or process tree data.

| Traversal   | Order               | Description                                                          |
| :---------- | :------------------ | :------------------------------------------------------------------- |
| Level Order | Breadth-First       | Explores the tree level-by-level horizontally using a queue.         |
| In Order    | Left → Root → Right | Walks nodes recursively to extract values in sorted ascending order. |
| Pre Order   | Root → Left → Right | Explores parents before children; useful for cloning tree networks.  |
| Post Order  | Left → Right → Root | Explores children before parents; ideal for bottom-up deletions.     |

* **Pattern:** **Traverse → Visit → Return**
* **Key Insight:** Traversal methods walk through existing nodes without modifying the tree structure. Different traversal strategies expose different perspectives of the same data structure.

### Rebalance
Rebuilds an unbalanced tree into a balanced one.
* **Problem Solved:** Restore efficient search performance after repeated insertions create a skewed structure.
* **Pattern:** **Extract → Rebuild → Replace**
* **Key Insight:** An in-order traversal produces sorted values. Those values are then used to construct a new balanced tree using the same recursive build algorithm.

---

## Complexity Analysis

| Operation | Balanced Tree | Worst Case | Operational Justification                                                                     |
| :-------- | :------------ | :--------- | :-------------------------------------------------------------------------------------------- |
| Search    | $O(\log n)$   | $O(n)$     | Cuts lookups in half each step if balanced; degrades to linear scan if completely skewed.     |
| Insert    | $O(\log n)$   | $O(n)$     | Navigates path branches logarithmically before executing a constant pointer assignment swap.  |
| Delete    | $O(\log n)$   | $O(n)$     | Dominated by locating the target value node and tracking its corresponding in-order successor.|
| Traversal | $O(n)$        | $O(n)$     | Requires visiting every individual node across the structural framework exactly once.         |
| Rebalance | $O(n)$        | $O(n)$     | flattens nodes sequentially into a linear stream to rebuild uniform child configurations.     |

### Why This Matters
Balanced trees maintain logarithmic performance because each comparison eliminates roughly half of the remaining search space. As a tree becomes increasingly unbalanced, operations gradually degrade toward linear performance, reducing many of the advantages that make BSTs useful.

---

## Example Usage

```ruby
require_relative 'lib/node'
require_relative 'lib/tree'

# Sample numerical raw data stream
list = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

# Instantiates and auto-balances the tree configuration
tree = Tree.new(list)

# Render tree layout to the standard terminal output
tree.pretty_print

# Dynamically alter tree structural models
tree.insert(100)
tree.delete(67)

# Verify balance constraints
puts "Is the tree balanced? #{tree.balanced?}"

# Force clean structural alignment
tree.rebalance
```

### Example Output

```text
│           ┌── 6345
│       ┌── 324
│   ┌── 67
│   │   └── 23
└── 8
    │   ┌── 7
    │   │   └── 5
    └── 4
        └── 1
            └── 3
```

---

## Challenges & Lessons Learned

The most difficult part of this project was understanding how recursive tree operations modify a structure without losing parent-child relationships.

Initially, insertion, deletion, and tree construction felt like completely different problems. After tracing recursive calls and visualizing stack unwinding, I realized they all followed the same underlying pattern:
1. Move toward a smaller subtree
2. Solve the smaller problem
3. Return the subtree root
4. Reconnect it to the parent

Recognizing this pattern significantly improved my ability to reason about recursive algorithms and made complex tree operations easier to implement and debug.

---

## What I Learned

This project strengthened my understanding of:
* **Recursive Problem Solving:** Shifting from linear tracking states to divide-and-conquer methodologies.
* **Tree-Based Topologies:** Managing node-link networks and reference boundaries.
* **Traversal Strategies:** Implementing continuous iterative loops and safe recursive tracking passes.
* **Complexity Analysis:** Tracking efficiency costs and architectural limits over time.
* **Object-Oriented Design:** Encapsulating properties and models within clear public interface contracts.
* **Stack Execution Tracking:** Tracing functional frames to debug memory updates.

Most importantly, it taught me how recursive algorithms build, modify, and traverse hierarchical structures by solving smaller subproblems and reconnecting results during stack unwinding.

---

## Technologies Used

* **Ruby** — Core object-oriented language features
* **RSpec** — Behavior test suites and assertions
* **Object-Oriented Programming** — Modular class design and encapsulation
* **Data Structures & Algorithms** — Binary graphs and tree searching optimizations
* **Recursion** — Call-stack management and divide-and-conquer design patterns

---

## Key Takeaways

Building a Binary Search Tree from scratch provided practical experience implementing recursive algorithms on hierarchical data structures. 

The project reinforced core software engineering concepts including abstraction, recursion, traversal strategies, complexity analysis, and maintaining data structure invariants during mutation operations.

Most importantly, it helped me develop a reusable mental model for recursive problem solving that extends beyond trees and applies to many divide-and-conquer style algorithms.
