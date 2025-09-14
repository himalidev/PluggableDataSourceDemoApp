//
//  CachingDataSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//

import Combine

actor SingleValueCache<T: Sendable> {
    private var value: T?
    private var inFlight: Task<T, Error>?

    func clear() { value = nil }

    func getOrLoad(_ loader: @Sendable @escaping () async throws -> T) async throws -> T {
        if let v = value { return v }
        if let t = inFlight { return try await t.value }
        let t = Task { try await loader() }
        inFlight = t
        defer { inFlight = nil }
        let v = try await t.value
        value = v
        return v
    }
}

struct CachingDataSource<Base: DataSource & Sendable>: DataSource, Sendable where Base.Item: Sendable {
    typealias Item = Base.Item
    let base: Base
    private let cache = SingleValueCache<[Item]>()

    func load() async throws -> [Item] {
        try await cache.getOrLoad { try await base.load() }
    }

    func invalidate() async { await cache.clear() }
}

extension CachingDataSource: Refreshable {
    func refresh() async { await invalidate() }
}
