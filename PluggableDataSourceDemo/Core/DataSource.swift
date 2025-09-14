//
//  DataSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
protocol DataSource {
    associatedtype Item
    func load() async throws -> [Item]
}
