//
//  ContentView.swift
//  RestAPI-POST
//
//  Created by 渡邊魁優 on 2023/05/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject var shopViewModel = ShopData()
    var body: some View {
        NavigationStack {
            List {
                ForEach(shopViewModel.shopList.indices, id: \.self) { index in
                    HStack {
                        VStack {
                            Text("店名：\(shopViewModel.shopList[index].name)")
                            Text("ID：\(shopViewModel.shopList[index].id)")
                        }
                        Spacer()
                        VStack {
                            Text("緯度：\(shopViewModel.shopList[index].latitude)")
                            Text("経度：\(shopViewModel.shopList[index].longitude)")
                        }
                    }
                }
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        shopViewModel.onAppear()
                    }) {
                        Image(systemName: "desktopcomputer.and.arrow.down")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        shopViewModel.isAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear(perform: shopViewModel.onAppear)
        .sheet(isPresented: $shopViewModel.isAddView) {
            AddShopView(save: { text, value1, value2 in
                shopViewModel.addParameters(name: text, longitude: value1, latitude: value2)
            }, cancel: {
                shopViewModel.didTapAddViewCancelButton()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
