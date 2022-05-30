//
//  TestSubscriber+Values.swift
//
//
//  Created by Dezork
    

import Foundation

public extension TestSubscriber where Input: Equatable {

    @discardableResult
    func assertValues(_ values: [Input]) throws -> Self {
        if self.values != values {
            throw throwException("\(self.values) is not equal to \(values)")
        }
        return self
    }
    
    @discardableResult
    func assertValues(_ values: Input...) throws -> Self {
        return try assertValues(values)
    }

    @discardableResult
    func assertValue(_ value: Input) throws -> Self {
        if !values.contains(value) {
            throw throwException("\(self.values) doesn't contain \(value)")
        }
        return self
    }

    @discardableResult
    func assertValues(_ values: Input..., at positions: Int...) throws -> Self {
        return try assertValues(values, at: positions, using: ==)
    }

    @discardableResult
    func assertValues(_ values: [Input], at positions: [Int]) throws -> Self {
        return try assertValues(values, at: positions, using: ==)
    }
}

public extension TestSubscriber {

    @discardableResult
    func assertNoValues() throws -> Self {
        try assertValueCount(0)
        return self
    }
    
    @discardableResult
    func assertValues(_ values: [Input], using comparator: (Input, Input) -> Bool) throws -> Self {
        try assertValueCount(values.count)
        try zip(values, self.values).enumerated().forEach { index, values in
            let (expected, actual) = values
            if !comparator(expected, actual) {
                throw throwException("Value at position \(index) differ; Expected: \(expected), Actual: \(actual)")
            }
        }
        return self
    }

    @discardableResult
    func assertValues(_ values: Input..., using comparator: (Input, Input) -> Bool) throws -> Self {
        return try assertValues(values, using: comparator)
    }

    @discardableResult
    func assertValueCount(_ count: Int) throws -> Self {
        guard values.count == count else {
            throw throwException("Value count differs; Expected: \(count), Actual: \(self.values.count)")
        }
        return self
    }
    
    @discardableResult
    func assertValues(_ values: Input..., at positions: Int...,using comparator: (Input, Input) -> Bool) throws -> Self {
        return try assertValues(values, at: positions, using: comparator)
    }

    @discardableResult
    func assertValues(_ values: [Input], at positions: [Int], using comparator: (Input, Input) -> Bool) throws -> Self {
        guard values.count == positions.count else { throw throwException("Values and positions should be equal size") }
        try zip(values, positions).forEach { try assertValue($0.0, at: $0.1, using: comparator) }
        return self
    }

    @discardableResult
    func assertValue(_ value: Input, at position: Int, using comparator: (Input, Input) -> Bool) throws -> Self {
        guard position > .zero else { throw throwException("Position should be greater than 0") }
        guard position < values.endIndex else {
            throw throwException("Position: \(position) is greater than last index \(values.endIndex - 1)")
        }
        guard comparator(values[position], value)  else { throw throwException("There is no value of \(value) at position \(position)") }
        return self
    }

}
