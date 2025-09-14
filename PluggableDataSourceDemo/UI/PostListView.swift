//
//  PostListView.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import SwiftUI
import Combine

struct PostListView: View {
    @StateObject private var vm: PostListViewModel

    init(dataSource: AnyDataSource<Post>) {
        _vm = StateObject(wrappedValue: PostListViewModel(dataSource: dataSource))
    }

    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading…")
            } else if let err = vm.error {
                Text("Error: \(err)")
                    .foregroundStyle(.red)
            } else {
                List(vm.posts) { post in
                    Text(post.title)
                }
            }
        }
        .task { await vm.load() }
        .navigationTitle("Posts")
    }
}
