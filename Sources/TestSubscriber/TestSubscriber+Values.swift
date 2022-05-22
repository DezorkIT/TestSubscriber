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
        guard values.count == 0 else { throw throwException("Some values were published") }
        return self
    }
}
