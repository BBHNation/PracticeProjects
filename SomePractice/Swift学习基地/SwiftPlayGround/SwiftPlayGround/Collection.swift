//
//  Collection.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 集合类型（Collection Types）
import Foundation

class CollectionTypes {
    /*
    Swift 语言提供 Arrays 、 Sets 和 Dictionaries 三种基本的集合类型用来存储集合数据。
     数组(Arrays)是有序数据的集。
     集合(Sets)是无序无重复数据的集。
     字典(Dictionaries)是无序的键值对的集。
     */
    
    /*注意:
     Swift 的 Arrays 、 Sets 和 Dictionaries 类型被实现为泛型集合。*/
    
    /// 集合的可变性
    func canChange() {
        /*
         如果创建一个 Arrays 、 Sets 或 Dictionaries 并且把它分配成一个变量，
         这个集合将会是可变的。这意味着我们 可以在创建之后添加更多或移除已存在的数据项，
         或者改变集合中的数据项。如果我们把 Arrays 、 Sets 或 ionaries 分配成常量，
         那么它就是不可变的，它的大小和内容都不能被改变。
         */
    }
    
    /// 数组
    func Array() {
        /*____________________________________*/
        // 创建空数组
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.") // 打印 "someInts is of type [Int] with 0 items."
        someInts.append(3)
        // someInts 现在包含一个 Int 值
        someInts = []
        // someInts 现在是空数组，但是仍然是 [Int] 类型的。
        
        // 创建带有默认值的数组
        /* Swift 中的 Array 类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新 数组的数据项数量( count )和适当类型的初始值( repeating )传入数组构造函数:*/
        // var threeDoubles = Array(repeating: 0.0, count: 3)
        
        // threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
        
        someInts = [2,3,4,5,6]
        let helloArr = [3,4,5,6]
        someInts = someInts + helloArr//使用+来拼接
        
        
        /*___________________________________*/
        /*访问和修改数组*/
        
        /*可以使用数组的只读属性 count 来获取数组中的数据项数量:*/
        print(someInts.count)
        /*也可以使用 append(_:) 方法在数组后面添加新的数据项:*/
        print(someInts.append(3))
        /*除此之外，使用加法赋值运算符( += )也可以直接在数组后面添加一个或多个拥有相同类型的数据项:*/
        print(someInts+=[3])
        
        /*利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的。*/
        var shoppingList = [String]()
        shoppingList[4...6] = ["Bananas", "Apples"] // shoppingList 现在有6项
        
        /*调用数组的 insert(_:at:) 方法来在某个具体索引值之前添加数据项:*/
        shoppingList.insert("good", at: 0)
        
        /*类似的我们可以使用 remove(at:) 方法来移除数组中的某一项。*/
        shoppingList.remove(at: 6)
        
        /*如果我们只想把数组中的最后一项移除，可以使用 removeLast() 方法而不是 remove(at:) 方法来避免我们需要获 取数组的 count 属性。*/
        shoppingList.removeLast()
        
        
        /*_______________________________________*/
        /*数组的遍历*/
        for item in shoppingList {
            print(item)
        }
        
        /*如果我们同时需要每个数据项的值和索引值，
         可以使用 enumerated() 方法来进行数组遍历。 
         enumerated() 返回 一个由每一个数据项索引值和数据值组成的元组。
         我们可以把这个元组分解成临时常量或者变量来进行遍历:*/
        for (index, value) in shoppingList.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        
    }
    
    /// 集合
    func Sets() {
        /*____________________________________________*/
        /*集合(Set)用来存储相同类型并且没有确定顺序的值*/
        /*一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，
         该类型必须提供一个方法来计算它的哈希 值。一个哈希值是 Int 类型的，
         相等的对象哈希值必须相同，比如 a==b ,
         因此必须 a.hashValue == b.hashValu e。*/
        
        /*Swift 的所有基本类型(比如 String , Int , Double 和 Bool )
         默认都是可哈希化的，可以作为集合的值的类型或 者字典的键的类型。
         没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。*/
        
        /*注意: 你可以使用你自定义的类型作为集合的值的类型或者是字典的键的类型，但你需要使你的自定义类型符合 Swift 标准库中的 Hashable 协议。符合 Hashable 协议的类型需要提供一个类型为 Int 的可读属性 hashValue 。由类 型的 hashValue 属性返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。
         
         因为 Hashable 协议符合 Equatable 协议，所以遵循该协议的类型也必须提供一个"是否相等"运算符( == )的实 现。这个 Equatable 协议要求任何符合 == 实现的实例间都是一种相等的关系。也就是说，对于 a,b,c 三个值来 说， == 的实现必须满足下面三种情况:
         • a == a (自反性)
         • a == b 意味着 b == a (对称性)
         • a == b && b == c 意味着 a == c (传递性)*/
        
        /*____________________________________________*/
        /*创建一个集合*/
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.") // 打印 "letters is of type Set<Character> with 0 items."
        letters.insert("a")
        // letters 现在含有1个 Character 类型的值
        letters = []
        // letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型
        
        /*数组创建集合*/
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"] // favoriteGenres 被构造成含有三个初始值的集合
        
        /*____________________________________________*/
        /*修改和访问一个集合*/
        print(favoriteGenres.count)//使用count访问数量
        print(favoriteGenres.isEmpty)//使用isEmpty来判空，检查count是否为0
        
        favoriteGenres.insert("ewr")//使用insert来添加数据
        favoriteGenres.remove(at: favoriteGenres.index(of: "Rock")!)//使用remove来删除数据
        print(favoriteGenres.contains("ewr"))//使用contain来判断是否含有某个数值
        
        
        /*____________________________________________*/
        /*遍历一个集合*/
        for genre in favoriteGenres {
            print(genre)
        }
        
        // 排序后的Set，使用操作符号‘<’元素进行比较
        for genre in favoriteGenres.sorted() {
            print(genre)
        }
        
        
        /*____________________________________________*/
        /*集合操作*/
        /*你可以高效地完成 Set 的一些基本操作，比如把两个集合组合到一起，
         判断两个集合共有元素，或者判断两个集 合是否全包含，部分包含或者不相交。*/
        /*
         • 使用 intersection(_:) 方法根据两个集合中都包含的值创建的一个新的集合。
         • 使用 symmetricDifference(_:) 方法根据在一个集合中但不在两个集合中的值创建一个新的集合。 
         • 使用 union(_:) 方法根据两个集合的值创建一个新的集合。
         • 使用 subtracting(_:) 方法根据不在该集合中的值创建一个新的集合。*/
        let oddDigits: Set = [1,3,5,7,9]
        let evenDigits: Set = [0,2,4,6,8]
        let singleDigitPrimeNumbers: Set = [2,3,5,7]
        
        print(oddDigits.union(evenDigits).sorted())
        print(oddDigits.intersection(evenDigits).sorted())
        // []
        print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())
        // [1, 9]
        print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())
        // [1, 2, 9]
        
        
        /*
         • 使用“是否相等”运算符( == )来判断两个集合是否包含全部相同的值。
         • 使用 isSubset(of:) 方法来判断一个集合中的值是否也被包含在另外一个集合中。
         • 使用 isSuperset(of:) 方法来判断一个集合中包含另一个集合中所有的值。
         • 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或 者父集合并且两个集合并不相等。
         • 使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值(是否没有交集)。*/
        let houseAnimals: Set = ["?", "?"]
        let farmAnimals: Set = ["?", "?", "?", "?", "?"]
        let cityAnimals: Set = ["?", "?"]
        print(houseAnimals.isSubset(of: farmAnimals))
        // true
        print(farmAnimals.isSuperset(of: houseAnimals))
        // true
        print(farmAnimals.isDisjoint(with: cityAnimals))
        // true
    }

    /// 字典
    func Dics() {
        /*____________________________________________*/
        /*注意:
         一个字典的 Key 类型必须遵循 Hashable 协议，就像 Set 的值类型。*/
        /*创建字典*/
        var namesOfIntegers = [Int : String]()
        // namesOfIntegers 是一个空的 [Int: String] 字典
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:]
        // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        /*____________________________________________*/
        /*访问和修改字典*/
        print(airports.count)
        print(airports.isEmpty)
        print(airports.index(forKey: "YYZ") ?? "nil")
        print(airports.updateValue("good", forKey: "YYZ") ?? "nil")
        //我们还可以使用下标语法来通过给某个键的对应值赋值为 nil 来从字典里移除一个键值对:
        airports["APL"] = "Apple Internation"
        // "Apple Internation" 不是真的 APL 机场, 删除它 
        airports["APL"] = nil
        // APL 现在被移除了
        airports.removeValue(forKey: "YYZ")
        
        /*____________________________________________*/
        /*字典遍历*/
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        
        /* Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，
         可以对字典的 keys 或 values 属性使 用 sorted() 方法。*/
    }
}
