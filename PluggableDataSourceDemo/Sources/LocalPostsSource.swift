//
//  LocalPostsSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import Foundation

struct LocalPostsSource: DataSource {
    func load() async throws -> [Post] {
        guard let url = Bundle.main.url(forResource: "posts", withExtension: "json") else {
            throw NSError(domain: "LocalPostsSource", code: 1)
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
