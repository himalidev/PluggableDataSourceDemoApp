//
//  AnyDataSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
struct AnyDataSource<Item>: DataSource {
    private let _load: () async throws -> [Item]

    init<DS: DataSource>(_ base: DS) where DS.Item == Item {
        self._load = base.load
    }

    init(_ load: @escaping () async throws -> [Item]) {
        self._load = load
    }

    func load() async throws -> [Item] { try await _load() }
}

extension AnyDataSource {
    func map<U>(_ transform: @escaping (Item) -> U) -> AnyDataSource<U> {
        AnyDataSource<U> {
            let items = try await self.load()
            return items.map(transform)
        }
    }
}
