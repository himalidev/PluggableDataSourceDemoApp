//
//  LoggingDataSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//

import Foundation

struct LoggingDataSource<Base: DataSource>: DataSource {
    typealias Item = Base.Item
    let base: Base

    func load() async throws -> [Item] {
        let start = Date()
        let items = try await base.load()
        let ms = Int(Date().timeIntervalSince(start) * 1000)
        print("Loaded \(items.count) items in \(ms) ms")
        return items
    }
}
