//
//  APIManager.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/10/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func fetchDiscGolfData(param: String, completion: @escaping ([DiscGolfDisc]?, Error?) -> Void) {
          if let url = URL(string: "https://discit-api.fly.dev/\(param)") {
              URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                      do {
                          let discs = try JSONDecoder().decode([DiscGolfDisc].self, from: data)
                          completion(discs, nil)
                      } catch {
                          completion(nil, error)
                      }
                  } else if let error = error {
                      completion(nil, error)
                  }
              }.resume()
          } else {
              let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
              completion(nil, error)
          }
      }
}

enum discParams {
    
}
