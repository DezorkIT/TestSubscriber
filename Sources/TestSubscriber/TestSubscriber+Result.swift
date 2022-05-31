//
//  TestSubscriber+Result.swift
//
//
//  Created by Dezork
    

import Foundation

public extension TestSubscriber where Input: Equatable {

    @discardableResult
    func assertResult(with values: Input...) throws -> Self {
        return try assertResult(with: values)
    }
    
    @discardableResult
    func assertResult(with values: [Input]) throws -> Self {
        return try assertResult(with: values, using: ==)
    }
}

public extension TestSubscriber where Failure: Equatable {

    @discardableResult
    func assertResult(with error: Failure) throws -> Self {
        return try assertResult(with: error, using: ==)
    }
}

public extension TestSubscriber where Input: Equatable, Failure: Equatable {

    @discardableResult
    func assertResult(with values: Input..., error: Failure) throws -> Self {
        return try assertResult(with: values, error: error)
    }

    @discardableResult
    func assertResult(with values: [Input], error: Failure) throws -> Self {
        try assertValues(values)
            .assertError(error)
        return self
    }
}

public extension TestSubscriber {
    
    @discardableResult
    func assertResult(with values: Input...,
                      using comparator: (Input, Input) -> Bool) throws -> Self {
        return try assertResult(with: values, using: comparator)
    }
    
    @discardableResult
    func assertResult(with values: [Input],
                      using comparator: (Input, Input) -> Bool) throws -> Self {
        try assertValues(values, using: comparator)
            .assertNoError()
            .assertFinished()
        return self
    }
    
    @discardableResult
    func assertEmptyResult() throws -> Self {
        try assertNoValues()
            .assertNoError()
            .assertFinished()
        return self
    }
    
    @discardableResult
    func assertNoIntrecationsResult() throws -> Self {
        try assertNoValues()
            .assertNoError()
            .assertNotFinished()
        return self
    }
    
    @discardableResult
    func assertResultWithAnyError() throws -> Self {
        try assertHasError()
            .assertNoValues()
        return self
    }
    
    @discardableResult
    func assertResult(with errorType: Error.Type) throws -> Self {
        try assertError(with: errorType)
            .assertNoValues()
        return self
    }

    @discardableResult
    func assertResult(with error: Failure,
                      using comparator: (Failure, Failure) -> Bool) throws -> Self {
        try assertError(error, using: comparator)
            .assertNoValues()
        return self
    }
}
