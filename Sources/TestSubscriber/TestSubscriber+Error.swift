//
//  TestSubscriber+Error.swift
//
//
//  Created by Dezork
    

import Foundation

public extension TestSubscriber where Failure: Equatable {
    
    @discardableResult
    func assertError(_ error: Failure) throws -> Self {
        try assertHasError()
        if let safeError = self.error,
           safeError != error {
            throw throwException("Error differ; Expected: \(error), Actual: \(safeError)")
        }
        return self
    }
}

public extension TestSubscriber {

    @discardableResult
    func assertHasError() throws -> Self {
        if error == nil  {
            throw throwException("Publisher doesn't have an error")
        }
        return self
    }
    
    @discardableResult
    func assertError(with errorType: Error.Type) throws -> Self {
        try assertHasError()
        if let error = self.error,
           type(of: error) != errorType {
           throw throwException("there is no error with type: \(errorType)")
        }
        return self
    }
    
    @discardableResult
    func assertNoError() throws -> Self {
        if let error = self.error  {
            throw throwException("Publisher has an error \(error)")
        }
        return self
    }

    @discardableResult
    func assertError(_ error: Failure, using comparator: (Failure, Failure) -> Bool) throws -> Self {
        try assertHasError()
        if let safeError = self.error,
           !comparator(error, safeError) {
            throw throwException("Error differ; Expected: \(error), Actual: \(safeError)")
        }
        return self
    }
}
