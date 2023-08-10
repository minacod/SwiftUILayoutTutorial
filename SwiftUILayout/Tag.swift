//
//  Tag.swift
//  SwiftUILayout
//
//  Created by Mina Azer on 10/08/2023.
//

import Foundation
import Fakery

struct Tag: Equatable, Identifiable {
    let id: String = UUID().uuidString
    var name: String
    
    static var mock: Tag {
        let faker = Faker.init()
        return.init(name: faker.name.firstName())
    }
}

extension [Tag] {
    static func mocks(count: Int = 50) -> [Tag] {
        var array : [Tag] = []
        for _ in 0..<count {
            array.append(.mock)
        }
        return array
    }
}
