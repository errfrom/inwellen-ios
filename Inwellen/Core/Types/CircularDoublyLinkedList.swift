//
//  CircularDoublyLinkedList.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 20.06.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

struct CircularDoublyLinkedList<T> {
    
    // - Data
    private(set) var head: Node?
    private(set) var tail: Node?
    
    // - Node Typealias
    typealias Node = LinkedListNode<T>
    
    // - Node Class
    class LinkedListNode<T> {
        var value: T
        fileprivate(set) var next: LinkedListNode?
        fileprivate(set) var prev: LinkedListNode?
        
        init(with value: T) {
            self.value = value
        }
    }
    
}

// MARK: -
// MARK: - Interface

extension CircularDoublyLinkedList {
    
    /// Creates a circular doubly linked list containing one value.
    /// - Complexity: O(1)
    static func singleton(_ newValue: T) -> CircularDoublyLinkedList {
        let newNode = Node(with: newValue)
        var linkedList = CircularDoublyLinkedList()
        
        newNode.next = newNode
        newNode.prev = newNode
        linkedList.head = newNode
        linkedList.tail = newNode
        return linkedList
    }

    /// Appends a value to the end of the list.
    /// - Complexity: O(1)
    mutating func append(_ newValue: T) {
        guard head != nil else {
            return self = .singleton(newValue)
        }
        
        let newNode = Node(with: newValue)
        newNode.next = head
        newNode.prev = tail
        head?.prev = newNode
        tail?.next = newNode
        tail = newNode
    }
    
    /// Removes the first value from the list.
    /// - Complexity: O(1)
    @discardableResult mutating func removeFirst() -> T? {
        guard head != nil else { return nil }
        
        let removedValue = head?.value
        
        if head === tail {
            self = .init()
            return removedValue
        } else {
            head = head?.next
            head?.prev = tail
            tail?.next = head
            return removedValue
        }
    }
    
    /// Moves the list head pointer forward to point to the next node.
    /// - Complexity: O(1)
    @discardableResult mutating func moveHeadForward() -> T? {
        guard head !== tail else { return nil }
        
        tail = head
        head = head?.next
        return head?.value
    }
    
    /// Moves the list head pointer backward to point to the previous node.
    /// - Complexity: O(1)
    @discardableResult mutating func moveHeadBackward() -> T? {
        guard head !== tail else { return nil }
        
        head = tail
        tail = tail?.prev
        return head?.value
    }

    /// Moves the list head pointer *n* steps forward.
    /// - Complexity: O(*n*)
    @discardableResult mutating func moveHeadForward(steps: Int) -> T? {
        return steps.times { moveHeadForward() } ?? nil
    }

    /// Moves the list head pointer *n* steps backward.
    /// - Complexity: O(*n*)
    @discardableResult mutating func moveHeadBackward(steps: Int) -> T? {
        return steps.times { moveHeadBackward() } ?? nil
    }

    /// Get the value of the node at a distance of *n* steps from the head node.
    /// - Complexity: O(*n*)
    func value(atDistance steps: Int) -> T? {
        var ptr = head
        steps.times { ptr = ptr?.next }
        return ptr?.value
    }

    /// Returns the first value of the list that satisfies the given predicate
    /// and its distance from the head.
    /// - Complexity: O(*n*)
    func first(where predicate: (T) throws -> Bool) rethrows -> (result: T, steps: Int)? {
        guard var ptr = head else { return nil }
        var distance = 0

        repeat {
            if try predicate(ptr.value) {
                return (result: ptr.value, steps: distance)
            } else {
                guard let next = ptr.next else { return nil }
                ptr = next
                distance += 1
            }
        } while ptr !== head

        return nil
    }
    
}
