//
//  NetworkPostsSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import Foundation

struct NetworkPostsSource: DataSource, Sendable {
    func load() async throws -> [Post] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
