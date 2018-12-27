//
//  Category.swift
//  AR_physicsBody
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

//衝突のカテゴリ
struct Category {
    static let planeCategory = 0b1
    static let boxCategory = 0b010
    static let earthCategory = 0b100
    static let all = 0b111
}
