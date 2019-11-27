//
//  ApiUtil.swift
//  tutor
//
//  Created by Peranut W. on 24/11/2562 BE.
//  Copyright © 2562 KU. All rights reserved.
//

import Foundation

struct ResponseCallback<T> {
    var onSuccess: (T) -> Void
    var onFailure: (Int) -> Void
    var onError: (String) -> Void
}

class ApiUtil {

    private init() { }

    static func fetchJSON<T: Decodable>(url: String, headers: [String: String]? = nil, type: T.Type, callback: ResponseCallback<T>) {
        guard let url = URL(string: url) else { return }

        var request = URLRequest(url: url)

        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    callback.onError("Fetch Error: " + error!.localizedDescription)
                }
            }

            guard let data = data else { return }

            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode == 200) {
                    do {
                        let jsonData = try JSONDecoder().decode(type, from: data)

                        print(jsonData)

                        DispatchQueue.main.async {
                            callback.onSuccess(jsonData)
                        }

                    } catch let jsonError {
                        DispatchQueue.main.async {
                            callback.onError("JSON Parse Error: " + jsonError.localizedDescription)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        callback.onFailure(httpResponse.statusCode)
                    }
                }
            }
        }.resume()
    }

    static func postJSON(url: String, headers: [String: String], jsonBody: [String: Any]?, callback: ResponseCallback<Void>) {
        guard let url = URL(string: url) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        if let jsonBody = jsonBody {
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
            request.httpBody = jsonData
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    callback.onError("Fetch Error: " + error!.localizedDescription)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        callback.onSuccess(Void())
                    } else {
                        callback.onFailure(httpResponse.statusCode)
                    }
                }
            }
        }.resume()
    }
}
