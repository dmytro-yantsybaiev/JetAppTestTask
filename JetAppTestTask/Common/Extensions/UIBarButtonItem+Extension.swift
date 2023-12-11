//
//  UIBarButtonItem+Extension.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit
import Combine

extension UIRefreshControl {

    func publisher(for event: UIControl.Event) -> Publisher {
        Publisher(control: self, event: event)
    }
}

extension UIRefreshControl {

    struct Publisher: Combine.Publisher {

        typealias Output = Void
        typealias Failure = Never

        private let control: UIControl
        private let event: UIControl.Event

        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }

        func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(
                subscriber: subscriber,
                control: control,
                event: event
            )
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIRefreshControl {

    final class Subscription<S: Subscriber, Input: UIRefreshControl>: Combine.Subscription where S.Input == Void {

        private var subscriber: S?
        private let control: UIControl
        private let event: UIControl.Event

        init(subscriber: S, control: UIControl, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            self.event = event
            self.control.addTarget(self, action: #selector(eventHandler), for: event)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = self.subscriber?.receive(Void())
        }
    }
}

extension UIBarButtonItem {

    var publisher: Publisher {
        Publisher(output: self)
    }
}

extension UIBarButtonItem {

    struct Publisher: Combine.Publisher {

        typealias Output = UIBarButtonItem
        typealias Failure = Never

        let output: Output

        init(output: Output) {
            self.output = output
        }

        func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, input: output)
            subscriber.receive(subscription: subscription)
        }
    }
}

private extension UIBarButtonItem {

    final class Subscription<S: Subscriber, Input: UIBarButtonItem>: Combine.Subscription where S.Input == Input {

        private var subscriber: S?
        private let input: Input

        init(subscriber: S, input: Input) {
            self.subscriber = subscriber
            self.input = input
            input.target = self
            input.action = #selector(eventHandler)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(input)
        }
    }
}
