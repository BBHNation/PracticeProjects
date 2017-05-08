//
//  OptionalChain.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/27.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里是可选链式调用

import Foundation

class OptionalChain {
    func main() {
        //可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有 值，那么调用就会成功;如果可选值是 nil ，那么调用将返回 nil 。多个调用可以连接在一起形成一个调用 链，如果其中任何一个节点为 nil ，整个调用链都会失败，即返回 nil 。
        
        class Person {
            var residence: Residence?
        }
        class Residence {
            var rooms = [Room]()
            var numberOfRooms: Int {
                return rooms.count
            }
            subscript(i: Int) -> Room {
                get {
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            func printNumberOfRooms() {
                print("The number of rooms is \(numberOfRooms)")
            }
            var address: Address?
        }
        
        class Room {
            let name: String
            init(name: String) { self.name = name }
        }
        
        class Address {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if buildingName != nil {
                    return buildingName
                } else if buildingNumber != nil && street != nil {
                    return "\(String(describing: buildingNumber)) \(String(describing: street))"
                } else {
                    return nil
                } }
        }
        
        let per = Person()
        print(per.residence?.numberOfRooms ?? "nil")
        // residence可能为空，所以在后面加一个？来表示可选链式调用，如果链子中有一个为空则整个链子返回空
        
    }
}
