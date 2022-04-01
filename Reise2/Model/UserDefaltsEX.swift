//
//  UserDefaltsEX.swift
//  Reise2
//
//  Created by 酒匂竜也 on 2022/03/10.
//

import Foundation

class UserDefaultsEX: UserDefaults {
    
    //構造体としてデーターを出し入れすることができる
    //Elementは要素のため何でも要素として可能
    //Element = 要素、Codable = プロトコル(型)
    //JSONEncoderを用いてエンコード(Data型へ変換)→Userdefaultsへセット
//    食べログキャプチャー16を再度見直す必要ある
//Elementに入れることによってデーター型に変換するのでアプリ内に保存できる。
    func set<Element: Codable>(value: Element, forKey key: String) {
            let data = try? JSONEncoder().encode(value)
            UserDefaults.standard.setValue(data, forKey: key)

    
    }

    //Element = 要素、Codable = プロトコル(型)
    //JSONDecoderを用いてデコード(Data型を構造体へ変換)
//    取り出すときはデーター型として取り出すが、構造体として返してあげると構造体を持つこともできるし取り出すことも可能になる
    func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let element = try? JSONDecoder().decode(Element.self, from: data)
        return element
    }
}
