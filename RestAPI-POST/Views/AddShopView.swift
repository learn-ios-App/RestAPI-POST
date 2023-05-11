//
//  AddShopView.swift
//  RestAPI-POST
//
//  Created by 渡邊魁優 on 2023/05/11.
//

import SwiftUI

struct AddShopView: View {
    @State var name = ""
    @State var longitude: String = ""
    @State var latutude: String = ""
    
    let save: (String, Double, Double) -> Void
    let cancel: () -> Void
    
    var body: some View {
        VStack() {
            HStack {
                Text("名前：")
                TextField("", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            HStack {
                Text("緯度：")
                TextField("", text: $longitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            HStack {
                Text("経度：")
                TextField("", text: $latutude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            HStack {
                
                Button(action: {
                    cancel()
                }) {
                    Text("削除")
                        .padding()
                }
                
                Button(action: {
                    save(name, parse(text: longitude), parse(text: latutude))
                }) {
                    Text("保存")
                        .padding()
                }
            }
        }
    }
    private func parse(text: String) -> Double {
        return Double(text) ?? 0.0
    }
}

struct AddShopView_Previews: PreviewProvider {
    static var previews: some View {
        AddShopView(name: "", longitude: "", latutude: "", save: { _, _, _ in }, cancel: {})
    }
}
