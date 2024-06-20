//
//  UserDefaults.swift
//  CheapestOnEarth
//
//  Created by Limetree on 2024/06/20.
//

import Foundation

extension UserDefaults {
    func setObject<T: Encodable>(_ object: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(object) {
            set(data, forKey: key)
        }
    }
    
    func getObject<T: Decodable>(forKey key: String, type: T.Type) -> T? {
        if let data = data(forKey: key), let object = try? JSONDecoder().decode(type, from: data) {
            return object
        }
        return nil
    }
}
