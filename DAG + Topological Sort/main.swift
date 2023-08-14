//
//  main.swift
//  DAG + Topological Sort
//
//  Created by Alireza Karimi on 2023-08-14.
// Help buy chatgpt to write functions 

import Foundation

// Definition for a directed graph node.
class Node {
    var val: Int
    var neighbors: [Node]
    
    init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
}

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var indegrees = [Int](repeating: 0, count: numCourses)
    var graph = [Int: [Int]]()
    
    for edge in prerequisites {
        indegrees[edge[0]] += 1
        if graph[edge[1]] == nil {
            graph[edge[1]] = []
        }
        graph[edge[1]]?.append(edge[0])
    }
    
    var queue = [Int]()
    for i in 0..<numCourses {
        if indegrees[i] == 0 {
            queue.append(i)
        }
    }
    
    while !queue.isEmpty {
        let course = queue.removeFirst()
        if let nextCourses = graph[course] {
            for nextCourse in nextCourses {
                indegrees[nextCourse] -= 1
                if indegrees[nextCourse] == 0 {
                    queue.append(nextCourse)
                }
            }
        }
    }
    
    return indegrees.allSatisfy { $0 == 0 }
}

func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
    var graph = [Int: [Int]]()
    var indegrees = [Int](repeating: 0, count: numCourses)
    
    for edge in prerequisites {
        indegrees[edge[0]] += 1
        if graph[edge[1]] == nil {
            graph[edge[1]] = []
        }
        graph[edge[1]]?.append(edge[0])
    }
    
    var queue = [Int]()
    for i in 0..<numCourses {
        if indegrees[i] == 0 {
            queue.append(i)
        }
    }
    
    var order = [Int]()
    while !queue.isEmpty {
        let course = queue.removeFirst()
        order.append(course)
        
        if let nextCourses = graph[course] {
            for nextCourse in nextCourses {
                indegrees[nextCourse] -= 1
                if indegrees[nextCourse] == 0 {
                    queue.append(nextCourse)
                }
            }
        }
    }
    
    return order.count == numCourses ? order : []
}

// Test the functions
let numCourses1 = 2
let prerequisites1 = [[1, 0]]
print(canFinish(numCourses1, prerequisites1))  // Output: true

let numCourses2 = 4
let prerequisites2 = [[1, 0], [2, 0], [3, 1], [3, 2]]
print(canFinish(numCourses2, prerequisites2))  // Output: true

let numCourses3 = 2
let prerequisites3 = [[1, 0], [0, 1]]
print(canFinish(numCourses3, prerequisites3))  // Output: false

let numCourses4 = 4
let prerequisites4 = [[1, 0], [2, 0], [3, 1], [3, 2]]
print(findOrder(numCourses4, prerequisites4))  // Output: [0, 1, 2, 3]

let numCourses5 = 2
let prerequisites5 = [[1, 0], [0, 1]]
print(findOrder(numCourses5, prerequisites5))  // Output: []

