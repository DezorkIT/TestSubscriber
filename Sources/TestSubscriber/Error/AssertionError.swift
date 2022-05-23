//
//  AssertionError.swift
//
//
//  Created by Dezork
    

import Foundation

public struct AssertionError: Error, Equatable {

    private let message: String

    public init(_ message: String) {
        self.message = message
    }
}

extension AssertionError: CustomStringConvertible {

    public var description: String {
        return message
    }
}
