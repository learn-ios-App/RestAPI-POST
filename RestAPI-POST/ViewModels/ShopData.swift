//
//  ShopData.swift
//  RestAPI-POST
//
//  Created by 渡邊魁優 on 2023/05/11.
//

import Foundation

class ShopData: ObservableObject {
    @Published var shopList: [Shop] = []
    @Published var isAddView = false
    @Published var parameters: [String: Any] = [:]
    
    
    let shopAPIClient = ShopAPIClient()
    
    func onAppear() {
        Task {
            await loadShops()
        }
    }
    
    func addParameters(name: String, longitude: Double, latitude: Double) {
        parameters.updateValue(name, forKey: "name")
        parameters.updateValue(longitude, forKey: "longitude")
        parameters.updateValue(latitude, forKey: "latitude")
        print(parameters)
        
        isAddView = false
    }
    
    @MainActor
    private func loadShops() async {
        do {
            let shops = try await shopAPIClient.fetchArticles()
            self.shopList = shops
        } catch {
            let error = error as? APIError ?? APIError.unknown
            print(error.title)
        }
    }
    
    private func uploadShop() async {
        do {
            let result = try await shopAPIClient.postShop(parameters: parameters)
            print(result)
        } catch {
            let error = error as? APIError ?? APIError.unknown
            print(error.title)
        }
    }
    
    func didTapAddViewCancelButton() {
        isAddView = false
    }
}
