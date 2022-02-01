//
//  DataSource.swift
//  Realtime
//
//  Created by Eric Schweitzer on 1/31/22.
//

import UIKit
import UIKit

class DataSource {
    static let sharedDataSource = DataSource()
    
    var dataArray = [ResponseObj]()
    
    func downloadData(abv: String, completion: @escaping (_ success: Bool) -> Void ) {
        guard let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(abv)") else {
            print("URL error")
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let errorDescription = error?.localizedDescription {
                print("http error \(errorDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            if let data = data {
                do {
                    self.dataArray = try JSONDecoder().decode([ResponseObj].self, from: data)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            } else {
                print("No data returned")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        task.resume()
    }
}
