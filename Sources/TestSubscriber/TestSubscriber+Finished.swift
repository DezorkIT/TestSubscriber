//
//  TestSubscriber+Finished.swift
//
//
//  Created by Dezork
    

import Foundation

public extension TestSubscriber {

    @discardableResult
    func assertFinished() throws -> Self {
        if !finished {
            throw throwException("Not finished")
        }
        return self
    }
    
    @discardableResult
    func assertNotFinished() throws -> Self {
        if finished {
            throw throwException("Finished")
        }
        return self
    }
}
