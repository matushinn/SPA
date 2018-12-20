//
//  ItemSearchResaultSet.swift
//  MySearchApp
//
//  Created by 大江祥太郎 on 2018/12/19.
//  Copyright © 2018年 shotaro. All rights reserved.
//


class ItemSearchResaultSet :Codable{
    var resaultSet:ItemSearchResaultSet
    
    private enum CodingKeys:String,CodingKey{
        case resaultSet = "ResaultSet"
    }
}

//検索結果セット格納クラス
class ResaultSet: Codable {
    var firstObject:FirstObject
    
    private enum CodingKeys:String,CodingKey{
        case firstObject = "0"
    }
    
}

//検索結果の先頭を格納するクラス
class FirstObject: Codable {
    var resault:Resault
    
    private enum CodingKeys:String,CodingKey{
        case resault = "Resault"
    }
}

//検索結果格納クラス
class Resault: Codable {
    var items : [ItemData] = [ItemData]()
    required init(from decoder: Decoder) throws {
        //デコードのためのコンテナ取得
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //コンテナ内のキーを取得。キーが文字列であるため、数値の昇順でソートを行う
        let keys = container.allKeys.sorted{
            
        }
    }
}
