//
//  PostListViewModel.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import SwiftUI
import Combine

@MainActor
final class PostListViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?

    private let dataSource: AnyDataSource<Post>

    init(dataSource: AnyDataSource<Post>) {
        self.dataSource = dataSource
    }

    func load() async {
        isLoading = true
        error = nil
        do {
            posts = try await dataSource.load()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
