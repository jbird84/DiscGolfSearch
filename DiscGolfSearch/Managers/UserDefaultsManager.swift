//
//  UserDefaultsManager.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/8/24.
//

import Foundation

class UserDefaultsManager {
    
    enum Key: String {
        case allDiscs
    //NOTE: add more keys here as/if the app grows and needs UD
    }
    
    func saveData<T: Encodable>(_ data: T, for key: Key) {
         do {
             let encoder = JSONEncoder()
             let encodedData = try encoder.encode(data)
             UserDefaults.standard.set(encodedData, forKey: key.rawValue)
         } catch {
             print("Unable to encode data to UserDefaults: \(error)")
         }
     }
    
    func loadData<T: Decodable>(for key: Key) -> T? {
            if let data = UserDefaults.standard.data(forKey: key.rawValue) {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    return decodedData
                } catch {
                    print("Error decoding data from UserDefaults: \(error)")
                    return nil
                }
            }
            return nil
        }
        
        func clearData(for key: Key) {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
}
