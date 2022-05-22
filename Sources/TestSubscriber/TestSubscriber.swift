//
//  TestSubscriber.swift
//
//
//  Created by Dezork

import Combine
import Foundation

public final class TestSubscriber<Input, Failure> where Failure: Error {

    internal var values: [Input] = []
    internal var errors: [Failure] = []
    internal var completed: Bool = false

    private let demand: Subscribers.Demand

    public convenience init() {
        self.init(demand: .unlimited)
    }
    public init(demand: Subscribers.Demand) {
        self.demand = demand
    }
}

extension TestSubscriber: Subscriber {

    public func receive(subscription: Subscription) {
        subscription.request(demand)
    }

    public func receive(_ input: Input) -> Subscribers.Demand {
        values.append(input)
        return .unlimited
    }

    public func receive(completion: Subscribers.Completion<Failure>) {
        switch completion {
        case .finished:
            completed = true
        case .failure(let error):
            errors.append(error)
        }
    }
}

extension TestSubscriber {

    func throwException(_ message: String) -> AssertionError {
        let resultMessage = """
        \(message), \
        values: \(values), \
        errors: \(errors), \
        completed: \(completed)
        """
        return AssertionError(resultMessage)
    }
}
