//
//  ShopAPIClient.swift
//  RestAPI-POST
//
//  Created by 渡邊魁優 on 2023/05/11.
//

import Foundation

class ShopAPIClient {
    func fetchArticles() async throws -> [Shop] {
        
        guard let url = URL(string: "https://qiita.com/api/v2/items") else {
            throw APIError.invalidURL
        }
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.networkError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.responseError
        }
        guard let result = try? JSONDecoder().decode([Shop].self, from: data) else {
            throw APIError.decodeError
        }
        return result
    }
    
    func postShop(parameters: [String: Any]) async throws -> Any {
        
        guard let url = URL(string: "https://qiita.com/api/v2/items") else {
            throw APIError.invalidURL
        }
        
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "POST"
        reqest.setValue("application/json", forHTTPHeaderField: "application/json")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: reqest, from: reqest.httpBody!)
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonResponse
        } catch {
            throw APIError.networkError
        }
    }
}
