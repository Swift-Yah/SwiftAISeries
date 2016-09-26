//: SWIFT: Frontier Seach Algorithm

import Foundation

// MARK: Data Structures

class Path {
	var contents = [Node]()
}

class Node {
	typealias Data = String

	var contents: Data
	var children = [Node]()

	init(contents: Data) {
		self.contents = contents
	}
}

/// MARK: Helper functions

protocol SearchStrategy {
	static func pickPath(paths: inout [Path]) -> Path
}

class DFS: SearchStrategy {
	static func pickPath(paths: inout [Path]) -> Path {
		return paths.removeLast()
	}
}

class BFS: SearchStrategy {
	static func pickPath(paths: inout [Path]) -> Path {
		return paths.removeFirst()
	}
}

func hasGoal(solution: Node.Data, path: Path) -> Bool {
	return !path.contents.filter({ $0.contents == solution }).isEmpty
}

func printer(path: Path) -> String {
	guard !path.contents.isEmpty else { return "NOTE: No Solution Found" }

	var result = "Solution Found! Path: "

	path.contents.forEach({ result += "\($0.contents), " })

	return result
}

/// MARK: Main algorithm

func search(query: Node.Data, startingNode: Node) -> Path {
	var frontier = [Path]()

	let path = Path()
	path.contents.append(startingNode);

	frontier.append(path)

	while !frontier.isEmpty {
		let pick = BFS.pickPath(paths: &frontier)

		guard !hasGoal(solution: query, path: pick) else { return pick }

		pick.contents.last?.children.forEach({
			let toAdd = Path()

			toAdd.contents.append(contentsOf: pick.contents)
			toAdd.contents.append($0)

			frontier.append(toAdd)
		})
	}

	return Path()
}

let nodeA = Node(contents: "a")
let nodeB = Node(contents: "b")
let nodeC = Node(contents: "c")
let nodeD = Node(contents: "d")
let nodeE = Node(contents: "e")
let nodeF = Node(contents: "f")
let nodeG = Node(contents: "g")
let nodeH = Node(contents: "h")
let nodeI = Node(contents: "i")
let nodeJ = Node(contents: "j")
let nodeK = Node(contents: "k")

// Node A children
nodeA.children.append(nodeB)
nodeA.children.append(nodeC)
nodeA.children.append(nodeD)

// Node B children
nodeB.children.append(nodeE)
nodeB.children.append(nodeF)

// Node C children
nodeC.children.append(nodeG)
nodeC.children.append(nodeH)
nodeC.children.append(nodeI)

// Node D children
nodeD.children.append(nodeJ)

// Node J children
nodeJ.children.append(nodeK)
nodeJ.children.append(nodeG)

let pathAToA = search(query: "a", startingNode: nodeA)
let pathAToD = search(query: "d", startingNode: nodeA)
let pathAToG = search(query: "g", startingNode: nodeA)
let pathAToZ = search(query: "z", startingNode: nodeA)

printer(path: pathAToA)
printer(path: pathAToD)
printer(path: pathAToG)
printer(path: pathAToZ)
