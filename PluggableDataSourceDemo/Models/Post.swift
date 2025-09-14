//
//  Post.swift
//  PluggableDataSourceDemo
//
//  Created by Himali Marasinghe on 2025-09-14.
//
import Foundation

struct Post: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
}
