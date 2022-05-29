//
//  TestSubscriber.swift
//
//
//  Created by Dezork

import Combine
import Foundation

public final class TestSubscriber<Input, Failure> where Failure: Error {

    var values: [Input] = []
    var error: Failure?
    var finished: Bool = false
    var subscriptions = Set<AnyCancellable>()

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
        subscription.store(in: &subscriptions)
    }

    public func receive(_ input: Input) -> Subscribers.Demand {
        values.append(input)
        return demand
    }

    public func receive(completion: Subscribers.Completion<Failure>) {
        switch completion {
        case .finished:
            finished = true
        case .failure(let error):
            self.error = error
        }
    }
}

extension TestSubscriber {

    func throwException(_ message: String) -> AssertionError {
        let resultMessage = """
        \(message), \
        values: \(values), \
        error: \(String(describing: error)), \
        finished: \(finished)
        """
        return AssertionError(resultMessage)
    }
}
