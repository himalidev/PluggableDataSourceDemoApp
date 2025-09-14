//
//  PagedNetworkPostsSource.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import Foundation

struct PagedNetworkPostsSource: PagedDataSource {
    func page(_ number: Int, size: Int) async throws -> [Post] {
        var comps = URLComponents(string: "https://jsonplaceholder.typicode.com/posts")!
        comps.queryItems = [
            URLQueryItem(name: "_page", value: "\(number)"),
            URLQueryItem(name: "_limit", value: "\(size)")
        ]
        let (data, response) = try await URLSession.shared.data(from: comps.url!)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
