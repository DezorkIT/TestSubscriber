//
//  TestSubscriberTests.swift
//
//
//  Created by Dezork

import XCTest
import Combine
import TestSubscriber

final class TestSubscriberTests: XCTestCase {

    func testValuesWithSubject() throws {
        let subject = PassthroughSubject<Int, TestError>()
        let subscriber = TestSubscriber<Int, TestError>()
        subject.subscribe(subscriber)
        subject.send(1)
        subject.send(2)
        subject.send(completion: .finished)
        
        try subscriber
            .assertValues(1,2)
            .assertFinished()
    }
    
    func testValuesAtPositionWithSubject() throws {
        let subject = PassthroughSubject<Int, TestError>()
        let subscriber = TestSubscriber<Int, TestError>()
        subject.subscribe(subscriber)
        subject.send(1)
        subject.send(2)
        subject.send(completion: .finished)

        try subscriber
            .assertValues(1,2, at: 0,1)
            .assertFinished()
    }
    
    func testEmptyResultWithSubject() throws {
        let subject = PassthroughSubject<Int, TestError>()
        let subscriber = TestSubscriber<Int, TestError>()
        subject.subscribe(subscriber)
        subject.send(completion: .finished)

        try subscriber
            .assertEmptyResult()
    }
    
    func testNoInteractionsResultWithSubject() throws {
        let subject = PassthroughSubject<Int, TestError>()
        let subscriber = TestSubscriber<Int, TestError>()
        subject.subscribe(subscriber)

        try subscriber
            .assertNoIntrecationsResult()
            .unsubscribe()
    }

    func testErrorWithSubject() throws {
        let subject = PassthroughSubject<Int, TestError>()
        let subscriber = TestSubscriber<Int, TestError>()
        subject.subscribe(subscriber)
        subject.send(completion: .failure(.known))

        try subscriber
            .assertError(.known)
    }
    
    func testResultErrorWithFuture() throws {
        let future = Future<Int, TestError>() { promise in
            promise(.failure(.unknown))
        }
        let subscriber = TestSubscriber<Int, TestError>()
        future.subscribe(subscriber)

        try subscriber
            .assertResult(with: .unknown)
    }
    
    func testResultValueWithFuture() throws {
        let future = Future<Int, TestError>() { promise in
            promise(.success(1))
            promise(.failure(.unknown))
        }
        let subscriber = TestSubscriber<Int, TestError>()
        future.subscribe(subscriber)

        try subscriber
            .assertResult(with: 1)
    }

    func testResultAnyErrorWithFuture() throws {
        let future = Future<Int, TestError>() { promise in
            promise(.failure(.known))
        }
        let subscriber = TestSubscriber<Int, TestError>()
        future.subscribe(subscriber)

        try subscriber
            .assertResultWithAnyError()
    }
    
}

enum TestError: Error {
    case known
    case unknown
}
