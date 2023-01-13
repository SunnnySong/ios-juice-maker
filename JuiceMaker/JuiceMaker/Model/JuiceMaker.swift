//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

struct JuiceMaker {
    func make(juice: Menu) throws {
        try checkFruit(according: juice.recipe)
        
        for (fruit, quantity) in juice.recipe {
            guard let stock = FruitStore.shared.stock(fruit: fruit) else {
                return
            }
            let newQuantity = stock - quantity
            FruitStore.shared.update(fruit: fruit, quantity: newQuantity)
        }
    }
    
    private func checkFruit(according recipe: [Fruits: Quantity]) throws {
        for (fruit, quantity) in recipe {
            guard let stock = FruitStore.shared.stock(fruit: fruit) else {
                return
            }
            guard stock.isNegative(subtraction: quantity) else {
                throw JuiceError.negativeQuantity(fruit: fruit)
            }
        }
    }
}

private extension Int {
    func isNegative(subtraction sub: Int) -> Bool {
        let result = (self - sub) >= 0
        return result
    }
}
