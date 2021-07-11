//
//  CircularDoublyLinkedListSpec.swift
//  InwellenTests
//
//  Created by Dzmitry Shuysky on 11.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import Quick
import Nimble

@testable import struct Inwellen.CircularDoublyLinkedList

final class CircularDoublyLinkedListSpec: QuickSpec {

    private typealias LinkedList = CircularDoublyLinkedList<Int>

    override func spec() {
        describe("circular doubly linked list") {
            var linkedList: CircularDoublyLinkedList<Int>!

            describe(".singleton") {
                it("creates a new list containing one value") {
                    linkedList = .singleton(0)
                    self.checkIfSingleton(linkedList, withValue: 0)
                }
            }

            describe(".append") {
                context("when the list is empty") {
                    it("creates a new list containing one value") {
                        linkedList = LinkedList()
                        linkedList.append(1)
                        self.checkIfSingleton(linkedList, withValue: 1)
                    }
                }

                context("when the list contains elements") {
                    it("appends a value to the end of the list") {
                        linkedList = .singleton(0)
                        linkedList.append(1)

                        expect(linkedList.tail?.value) == 1
                        expect(linkedList.head?.value) == 0
                        self.checkConsistency(ofNonEmptyLinkedList: linkedList)
                    }
                }
            }

            describe(".removeFirst") {
                context("when the list is empty") {
                    it("does nothing and returns nil") {
                        linkedList = LinkedList()
                        let removedElement = linkedList.removeFirst()

                        expect(removedElement).to(beNil())
                        expect(linkedList.head).to(beNil())
                    }
                }

                context("when the list is a singleton") {
                    it("removes the single value so that the list becomes empty") {
                        linkedList = .singleton(0)
                        let removedElement = linkedList.removeFirst()

                        expect(removedElement) == 0
                        expect(linkedList.head).to(beNil())
                    }
                }

                context("when the list contains more than one element") {
                    it("removes the first value from the list") {
                        linkedList = .singleton(0)
                        linkedList.append(1)
                        let removedElement = linkedList.removeFirst()

                        expect(removedElement) == 0
                        expect(linkedList.head?.value) == 1
                        self.checkConsistency(ofNonEmptyLinkedList: linkedList)
                    }
                }
            }

            describe(".moveHeadForward") {
                context("when the list is empty") {
                    it("does nothing and returns nil") {
                        linkedList = LinkedList()
                        let newHeadElement = linkedList.moveHeadForward()

                        expect(newHeadElement).to(beNil())
                        expect(linkedList.head).to(beNil())
                    }
                }

                context("when the list contains elements") {
                    it("moves the list head pointer forward") {
                        linkedList = .singleton(0)
                        linkedList.append(1)
                        linkedList.append(2)
                        let newHeadElement = linkedList.moveHeadForward()

                        expect(newHeadElement) == 1
                        expect(linkedList.head?.value) == 1
                        expect(linkedList.tail?.value) == 0
                        self.checkConsistency(ofNonEmptyLinkedList: linkedList)
                    }
                }
            }

            describe(".moveHeadBackward") {
                context("when the list is empty") {
                    it("does nothing and returns nil") {
                        linkedList = LinkedList()
                        let newHeadElement = linkedList.moveHeadBackward()

                        expect(newHeadElement).to(beNil())
                        expect(linkedList.head).to(beNil())
                    }
                }

                context("when the list contains elements") {
                    it("moves the list head pointer backward") {
                        linkedList = .singleton(0)
                        linkedList.append(1)
                        linkedList.append(2)
                        let newHeadElement = linkedList.moveHeadBackward()

                        expect(newHeadElement) == 2
                        expect(linkedList.head?.value) == 2
                        expect(linkedList.tail?.value) == 1
                        self.checkConsistency(ofNonEmptyLinkedList: linkedList)
                    }
                }
            }

            describe(".moveHeadForward(steps:)") {
                context("when the list contains elements") {
                    it("moves the list head pointer n steps forward") {
                        linkedList = LinkedList()
                        linkedList.append(0)
                        linkedList.append(1)
                        linkedList.append(2)
                        linkedList.append(3)
                        let newHeadElement = linkedList.moveHeadForward(steps: 2)

                        expect(newHeadElement) == 2
                        expect(linkedList.head?.value) == 2
                        expect(linkedList.tail?.value) == 1
                        self.checkConsistency(ofNonEmptyLinkedList: linkedList)
                    }
                }
            }

            describe(".moveHeadBackward(steps:)") {
                context("when the list contains elements") {
                    it("moves the list head pointer n steps backward") {
                        linkedList = LinkedList()
                        linkedList.append(0)
                        linkedList.append(1)
                        linkedList.append(2)
                        linkedList.append(3)
                        let newHeadElement = linkedList.moveHeadBackward(steps: 3)

                        expect(newHeadElement) == 1
                        expect(linkedList.head?.value) == 1
                        expect(linkedList.tail?.value) == 0
                        self.checkConsistency(ofNonEmptyLinkedList: linkedList)
                    }
                }
            }

            describe(".value(atDistance:)") {
                context("when the list contains elements") {
                    it("gets the value of the node at a distance of n steps") {
                        linkedList = LinkedList()
                        linkedList.append(0)
                        linkedList.append(1)
                        linkedList.append(2)
                        let resultElement = linkedList.value(atDistance: 2)

                        expect(resultElement) == 2
                    }
                }
            }

            describe(".first(where:)") {
                context("when the list contains values that satisfy the predicate") {
                    it("returns the first of these values") {
                        linkedList = .singleton(0)
                        linkedList.append(1)
                        linkedList.append(2)
                        let result = linkedList.first(where: { $0 > 0 })

                        expect(result) == 1
                    }
                }

                context("when the list doesn't contain values that satisfy the predicate") {
                    it("returns nil") {
                        linkedList = .singleton(0)
                        linkedList.append(1)
                        let result = linkedList.first(where: { $0 < 0 })

                        expect(result).to(beNil())
                    }
                }
            }
        }
    }

    private func checkIfSingleton(_ linkedList: LinkedList, withValue value: Int) {
        expect(linkedList.head?.value) == value
        expect(linkedList.tail?.value) == value
        expect(linkedList.head?.next).to(beIdenticalTo(linkedList.tail))
        expect(linkedList.tail?.next).to(beIdenticalTo(linkedList.head))
        self.checkConsistency(ofNonEmptyLinkedList: linkedList)
    }

}

// MARK: -
// MARK: - Consistency Check

fileprivate extension CircularDoublyLinkedListSpec {

    private func checkConsistency(ofNonEmptyLinkedList linkedList: LinkedList) {
        expect(linkedList.head).notTo(beNil())
        expect(linkedList.tail).notTo(beNil())
        expect(linkedList.head!.prev).to(beIdenticalTo(linkedList.tail))
        expect(linkedList.tail!.next).to(beIdenticalTo(linkedList.head))

        let maxLength: Int = 20
        var length: Int = 0
        var ptr = linkedList.head!

        repeat {
            guard length <= maxLength else {
                return fail("the maximum list length set for consistency check was exceeded")
            }

            expect(ptr.next).notTo(beNil())
            expect(ptr.next!.prev).to(beIdenticalTo(ptr))

            ptr = ptr.next!
            length += 1

        } while ptr !== linkedList.head
    }

}
