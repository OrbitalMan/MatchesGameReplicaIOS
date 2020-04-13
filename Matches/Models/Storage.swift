//
//  Storage.swift
//  TransportCV
//
//  Created by Stanislav on 09.01.2020.
//  Copyright © 2020 OrbitalMan. All rights reserved.
//

import Foundation

let Storage = StorageContainer.shared

class StorageContainer {
    
    static let shared = StorageContainer()
    
    private init() { }
    
    let defaults = UserDefaults.standard
    
    fileprivate let encoder = PropertyListEncoder()
    fileprivate let decoder = PropertyListDecoder()
    
    var selectedCellMap: CellMap {
		get { return defaults[#function] ?? .number }
        set { defaults[#function] = newValue }
    }
    
}

private extension UserDefaults {
    
    subscript <T: Codable>(_ key: String) -> T? {
        get {
            guard let data = data(forKey: key) else {
                return nil
            }
            do {
                return try Storage.decoder.decode([T].self, from: data).first
            } catch {
                print("UserDefaults decode error:", error)
                return nil
            }
        } set {
            guard let newValue = newValue else {
                removeObject(forKey: key)
                return
            }
            do {
                let newData = try Storage.encoder.encode([newValue])
                set(newData, forKey: key)
            } catch {
                print("UserDefaults encode error:", error)
            }
        }
    }
    
}

