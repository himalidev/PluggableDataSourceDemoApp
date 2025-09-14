//
//  PluggableDataSourceDemoApp.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//

import SwiftUI

@main
struct PluggableDataSourceDemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PostListView(
                    dataSource: AnyDataSource<Post>(
                        LoggingDataSource(
                            base: CachingDataSource(
                                base: RetryDataSource(
                                    base: NetworkPostsSource(),
                                    retries: 2,
                                    delay: .milliseconds(400),
                                    shouldRetry: { ($0 as? URLError) != nil }
                                )
                            )
                        )
                    )
                )
            }
        }
    }
}

