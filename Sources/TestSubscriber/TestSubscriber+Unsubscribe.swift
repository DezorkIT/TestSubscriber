//
//  TestSubscriber+Unsubscribe.swift
//
//
//  Created by Dezork
    

import Foundation

public extension TestSubscriber {
    func unsubscribe() {
        subscriptions.removeAll()
    }
}
