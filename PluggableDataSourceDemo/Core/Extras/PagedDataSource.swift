//
//  PagedDataSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import Foundation

protocol PagedDataSource {
    associatedtype Item
    func page(_ number: Int, size: Int) async throws -> [Item]
}

extension PagedDataSource {
    func first(size: Int = 20) async throws -> [Item] {
        try await page(1, size: size)
    }
}

protocol Refreshable {
    func refresh() async
}
