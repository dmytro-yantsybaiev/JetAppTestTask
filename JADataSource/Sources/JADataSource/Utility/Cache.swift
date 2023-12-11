//
//  Cache.swift
//
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import Foundation

public final class Cache<Key: Hashable, Value> {

    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval

    public init(
        dateProvider: @escaping () -> Date = Date.init,
        entryLifetime: TimeInterval = 12 * 60 * 60
    ) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }

    public func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    public func value(key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }

    public func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }

    public func removeAll() {
        wrapped.removeAllObjects()
    }
}

public extension Cache {

    subscript(key: Key) -> Value? {
        get {
            value(key: key)
        }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
}

private extension Cache {

    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int { key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }
}

private extension Cache {

    final class Entry {
        let value: Value
        let expirationDate: Date
        let creationDate: Date

        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
            self.creationDate = Date()
        }
    }
}
