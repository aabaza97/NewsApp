//
//  DataLoader.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 25/11/2021.
//

import Foundation

fileprivate let apiEndPoint: String = "https://newsapi.org/v2/everything?q=keyword&apiKey=33895be136484de0a4f6007cee094964"
fileprivate let apiKey: String = "33895be136484de0a4f6007cee094964"

enum RequestError: Error, CustomStringConvertible{
    case invalidURL
    
    var description: String {
        switch self {
        case .invalidURL: return "Invalid URL..."
        }
    }
}

class DataLoader {
    
    //MARK: -Properties
    static let shared: DataLoader = DataLoader()
    
    
    //MARK: -Inits
    
    private init() {}
    
    
    //MARK: -Functions
    
    public func makeRequest(with query: String = "keyword", completion: @escaping (_ count: Int?, _ articles: [Article]?, _ error: Error?) -> Void) -> Void {
        
        guard let url = self.formURL(with: query).url else {
            completion(nil, nil, RequestError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, nil, error)
                return
            }
            
            var response: Response?
            
            do {
                response = try JSONDecoder().decode(Response.self, from: data)
            } catch let e {
                completion(nil, nil, e)
                print("Decoding Error: \(e)")
            }
            
            guard let response = response else { return }
            
            completion(response.totalResults, response.articles, nil)
            
        }.resume()
    }
    
    private func formURL(with query: String = "keyword") -> URLComponents {
        var components = URLComponents()
        var q: String = query
        
        if query.isEmpty {q = "keyword"}
        
        components.scheme = "https"
        components.path = "/v2/everything"
        components.host = "newsapi.org"
        components.queryItems = [
            URLQueryItem(name: "q", value: q)
        ]
        
        return components
    }
}
