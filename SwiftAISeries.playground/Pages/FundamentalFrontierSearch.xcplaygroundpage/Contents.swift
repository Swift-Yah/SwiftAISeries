//: SWIFT 2a: Fundamental Frontier Seach Algorithm

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

func pickPath(paths: inout [Path]) -> Path {
	return paths.removeFirst()
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
		let pick = pickPath(paths: &frontier)

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

nodeA.children.append(nodeB)
nodeA.children.append(nodeC)
nodeC.children.append(nodeD)

let pathAToA = search(query: "a", startingNode: nodeA)
let pathAToD = search(query: "d", startingNode: nodeA)
let pathAToZ = search(query: "z", startingNode: nodeA)

printer(path: pathAToA)
printer(path: pathAToD)
printer(path: pathAToZ)
