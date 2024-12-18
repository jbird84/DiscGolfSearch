//
//  APIManager.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/10/23.
//

import Foundation
import OSLog

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
    
    // Function to download an image from a web link
        func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    os_log("Error downloading image: %@", log: OSLog.default, type: .error, error as CVarArg)
                    completion(nil)
                    return
                }
                completion(data)
            }
            task.resume()
        }
    
    // Function to download a Lottie animation file from a web link
       func downloadLottieFile(from url: URL, completion: @escaping (Data?) -> Void) {
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let data = data {
                   completion(data)
               } else {
                   completion(nil)
                   if let error = error {
                       os_log("Error downloading Lottie animation: %@", log: OSLog.default, type: .error, error as CVarArg)
                   }
               }
           }.resume()
       }
}


enum discParams {
    
}
