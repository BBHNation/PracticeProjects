//
//  AboutType.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/5/2.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 关于类型转换和嵌套类型
import Foundation
/// 类型转换
class AboutType {
    /*
     类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型 或者转换它的类型。
     */
    class MediaItem {
        var name : String
        init(name : String) {
            self.name = name
        }
    }
    
    class Movie : MediaItem {
        var director : String
        init(name : String, director : String) {
            self.director = director
            super.init(name: name)
        }
    }
    
    class Song : MediaItem {
        var artist : String
        init(name : String, artist : String) {
            self.artist = artist
            super.init(name: name)
        }
    }
    
    /*
     用类型检查操作符( is )来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回
     true ，否则返回 false 。
     */
    func main() {
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        // 数组 library 的类型被推断为 [MediaItem]
        
        var movieCount = 0
        var songCount = 0
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        print("Media library contains \(movieCount) movies and \(songCount) songs") // 打印 “Media library contains 2 movies and 3 songs”
        
        
        
        /*
         向下转型
         某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类
         型，用类型转换操作符(as? 或 as!)。
         */
        
        for item in library {
            if let movie = item as? Movie {
                print("Movie: '\(movie.name)', dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
        // Movie: 'Casablanca', dir. Michael Curtiz
        
        /*
         Any 和 AnyObject
         Swift 为不确定类型提供了两种特殊的类型别名:
         • Any 可以表示任何类型，包括函数类型。 
         • AnyObject 可以表示任何类类型的实例。
         
         Any 类型可以表示所有类型的值，包括可选类型。Swift 会在你用 Any 类型来表示一个可选值的时候，给你一
         个警告。如果你确实想使用 Any 类型来承载可选值，你可以使用 as 操作符显示转换为 Any ，如下所示:
         
         let optionalNumber: Int? = 3 
         things.append(optionalNumber) // 警告 
         things.append(optionalNumber as Any) // 没有警告
         */
    }
}

class QiantaoClass {
    /*
    枚举常被用于为特定类或结构体实现某些功能。类似的，枚举可以方便的定义工具类或结构体，从而为某个复杂 的类型所使用。为了实现这种功能，Swift 允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结 构体。
     */
    
    struct BlackjackCard {
        // 嵌套的Suit枚举
        enum Suit : Character {
            case Spades = "♠️", Hearts = "♥️", Diamonds = "♦️", Clubs = "♣️"
        }
        
        // 嵌套的Rank枚举
        enum Rank : Int {
            case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
            case Jack, Queen, King, Ace = 1
            struct Values {
                let first: Int, seconde: Int?
            }
            var values: Values {
                switch self {
                case .Ace:
                    return Values(first: 1, seconde: 11)
                case .Jack, .Queen, .King:
                    return Values(first: 10, seconde: nil)
                default:
                    return Values(first: self.rawValue, seconde: nil)
                }
            }
        }
        
        
        // BlackjackCard的属性和方法
        let rank: Rank, suit: Suit
        var description: String {
            var output = "suit is \(suit.rawValue)"
            output += " value is \(rank.values.first)"
            if let seconde = rank.values.seconde {
                output += " or \(seconde)"
            }
            return output
        }
    }
    

    
    
    func main() {
        let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
        print("the ace of spades: \(theAceOfSpades.description)")
        // 外部引用
        let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
        print(heartsSymbol)
    }
}
