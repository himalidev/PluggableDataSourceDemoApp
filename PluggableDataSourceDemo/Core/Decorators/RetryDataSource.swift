//
//  RetryDataSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import Foundation

struct RetryDataSource<Base: DataSource>: DataSource {
    typealias Item = Base.Item
    let base: Base
    let retries: Int
    let delay: Duration
    let shouldRetry: (Error) -> Bool

    func load() async throws -> [Item] {
        var attempt = 0
        while true {
            do {
                return try await base.load()
            } catch {
                guard attempt < retries, shouldRetry(error) else { throw error }
                attempt += 1
                try? await Task.sleep(for: delay)
            }
        }
    }
}
