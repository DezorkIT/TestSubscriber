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
}
