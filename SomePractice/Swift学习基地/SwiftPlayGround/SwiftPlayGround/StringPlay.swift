//
//  StringPlay.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// String的练习和学习

import Foundation

class StringPlay {
    
    /// 1.字符串字面量
    func stringLiterals() {
        /*
         Swift 的 String 和 Character 类型提供了
         快速和兼容 Unicode 的方式供你的代码使用
         
         字符串连接操作只需要简单地通过 + 符号将两个字符串相连即 可。
         与 Swift 中其他值一样，能否更改字符串的值，取决于其被定义为常量还是变量。
         
         每一个字符串都是由编码无关的 Unicode 字 符组成，
         并支持访问字符的多种 Unicode 表示形式(representations)。
         */
    }
    
    /// 2.初始化空字符
    func someInit() {
        let emptyString = "" // 空字符串字面量 
        let anotherEmptyString = String() // 初始化方法
        // 两个字符串均为空并等价。
        print(emptyString + anotherEmptyString)
        
        // 您可以通过检查其 Bool 类型的 isEmpty 属性来判断该字符串是否为空:
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        // 打印输出:"Nothing to see here"
    }
    
    /// 3.字符串可变性
    func canChange() {
        // 您可以通过将一个特定字符串分配给一个变量来对其进行修改，
        //或者分配给一个常量来保证其不会被修改:
        var variableString = "Horse"
        variableString += " and carriage"
        // variableString 现在为 "Horse and carriage"
        // let constantString = "Highlander"
        // constantString += " and another Highlander"
        // 这会报告一个编译错误 (compile-time error) - 常量字符串不可以被修改。
    }
    
    /// 4.字符串是值类型
    func isValue() {
        /*
         Swift 的 String 类型是值类型。 如果您创建了一个新的字符串，
         那么当其进行常量、变量赋值操作，或在函数/ 方法中传递时，会进行值拷贝。
         任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作。
         */
        
        /*
         很明显无论该值来自于哪里，都是您 独自拥有的。
         您可以确信传递的字符串不会被修改，除非你自己去修改它。
         */
    }
    
    /// 5.使用字符
    func useChar() {
        /*
         您可通过 for-in 循环来遍历字符串中的 characters 属性来获取每一个字符的值:
         */
        for character in "Dog!?".characters {
            print(character)
        }
        // 另外，通过标明一个 Character 类型并用字符字面量进行赋值，可以建立一个独立的字符常量或变量:
        let exclamationMark: Character = "!"
        print(exclamationMark)
        
        // 字符串可以通过传递一个值类型为 Character 的数组作为自变量来初始化:
        let catCharacters: [Character] = ["C", "a", "t", "!", "?"]
        let catString = String(catCharacters)
        print(catString)
        // 打印输出:"Cat!?"
    }
    
    /// 6.连接字符串和字符
    func combineStringAndChar() {
        // 使用+
        let string1 = "hello"
        let string2 = " there"
        var welcome = string1 + string2 // welcome 现在等于 "hello there"
        
        // 使用+=
        var instruction = "look over"
        instruction += string2
        // instruction 现在等于 "look over there"
        
        // 使用append
        let exclamationMark: Character = "!"
        welcome.append(exclamationMark)
        // welcome 现在等于 "hello there!"
    }
    
    /// 7.字符串插值
    func insertInString() {
        /*
         字符串插值是一种构建新字符串的方式，
         可以在其中包含常量、变量、字面量和表达式。 
         您插入的字符串字面量 的每一项都在以反斜线为前缀的圆括号中:
         */
        
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)" // message 是 "3 times 2.5 is 7.5"
        print(message)
        /*
         注意:
         插值字符串中写在括号中的表达式不能包含非转义反斜杠 ( \ )，并且不能包含回车或换行符。不过，插值字符 串可以包含其他字面量。
         */
    }
    
    /// 8.Unicode
    func unicode() {
        /*
         Unicode是一个国际标准，用于文本的编码和表示。 它使您可以用标准格式表示来自任意语言几乎所有的字 符，并能够对文本文件或网页这样的外部资源中的字符进行读写操作。 Swift 的 String 和 Character 类型是完 全兼容 Unicode 标准的。
         */
        
        /*
        Unicode 标量是对应字符或者修饰符的唯一的21位数字
         */
        
        //  注意: Unicode 码位(code poing) 的范围是 U+0000 到 U+D7FF 或者 U+E000 到 U+10FFFF 。Unicode 标量不包 括 Unicode 代理项(surrogate pair) 码位，其码位范围是 U+D800 到 U+DFFF 。
        
        
        //  字符串字面量可以包含以下特殊字符:
        //  • 转义字符 \0 (空字符)、 \\ (反斜线)、 \t (水平制表符)、 \n (换行符)、 \r (回车符)、 \" (双引号)、 \' (单引号)。
        //  • Unicode 标量，写成 \u{n} (u为小写)，其中 n 为任意一到八位十六进制数且可用的 Unicode 位码。

        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein" // "Imageination is more important than knowledge" - Enistein
        let dollarSign = "\u{24}" // $, Unicode 标量 U+0024
        let blackHeart = "\u{2665}" // ?, Unicode 标量 U+2665 
        let sparklingHeart = "\u{1F496}" // ?, Unicode 标量 U+1F496
        
        print(wiseWords + dollarSign + blackHeart + sparklingHeart)
        
        //可扩展的字形群集
        /*
         每一个 Swift 的 Character 类型代表一个可扩展的字形群。 一个可扩展的字形群是一个或多个可生成人类可读 的字符 Unicode 标量的有序排列。
         举个例子，字母 é 可以用单一的 Unicode 标量 é ( LATIN SMALL LETTER E WITH ACUTE , 或者 U+00E9 )来表 示。然而一个标准的字母 e ( LATIN SMALL LETTER E 或者 U+0065 ) 加上一个急促重音( COMBINING ACTUE ACCEN T )的标量( U+0301 )，这样一对标量就表示了同样的字母 é 。 这个急促重音的标量形象的将 e 转换成了 é 。
         在这两种情况中，字母 é 代表了一个单一的 Swift 的 Character 值，同时代表了一个可扩展的字形群。 在第一 种情况，这个字形群包含一个单一标量;而在第二种情况，它是包含两个标量的字形群:
         */
        let eAcute: Character = "\u{E9}" // é
        let combinedEAcute: Character = "\u{65}\u{301}" // e 后面加上 ? // eAcute 是 é, combinedEAcute 是 é
        print(eAcute)
        print(combinedEAcute)
    }
    
    /// 9.计算字符数量
    func caculateCharNum() {
        // 使用字符串的characters属性的count属性
        let unusualMenagerie = "Koala ?, Snail ?, Penguin ?, Dromedary ?"
        print("unusualMenagerie has \(unusualMenagerie.characters.count) characters") // 打印输出 "unusualMenagerie has 40 characters"
        
        /*
         注意在 Swift 中，使用可拓展的字符群集作为 Character 值来连接或改变字符串时，并不一定会更改字符串的字 符数量。
         例如，如果你用四个字符的单词 cafe 初始化一个新的字符串，然后添加一个 COMBINING ACTUE ACCENT ( U+030 1 )作为字符串的结尾。最终这个字符串的字符数量仍然是 4 ，因为第四个字符是 é ，而不是 e :
         */
        
        var word = "cafe"
        print("the number of characters in \(word) is \(word.characters.count)") // 打印输出 "the number of characters in cafe is 4"
        word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
        print("the number of characters in \(word) is \(word.characters.count)") // 打印输出 "the number of characters in café is 4"
        
        /*
         注意:
        可扩展的字符群集可以组成一个或者多个 Unicode 标量。这意味着不同的字符以及相同字符的不同表示方式可 能需要不同数量的内存空间来存储。所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间数 量。因此在没有获取字符串的可扩展的字符群的范围时候，就不能计算出字符串的字符数量。如果您正在处理一个长字符串，需要注意characters属性必须遍历全部的 Unicode 标量，来确定字符串的字符数量。
         另外需要注意的是通过characters属性返回的字符数量并不总是与包含相同字符的NSString的length属性相同，NSString的length属性是利用 UTF-16 表示的十六位代码单元数字，而不是 Unicode 可扩展的字符群集。
         
         当一个NSString的length被Swift的String值访问的时候，实际上调用了uft16Count。
         */
    }
    
    /// 10.访问和修改字符串
    func getAndChange() {
        /*
         字符串索引
         每一个String值都有一个关联的索引(index)类型，String.Index，它对应着字符串中的每一个Character的位置。
         */
        
        /*
         前面提到，不同的字符可能会占用不同数量的内存空间，所以要知道Character的确定位置，就必须从String开头遍历每一个Unicode 标量直到结尾。因此，Swift 的字符串不能用整数(integer)做索引。
         */
        
        /*
         通过调用 String 的 index(before:) 或 index(after:) 方法，可以立即得到前面或后面的一个索引。您还 可以通过调用 index(_:offsetBy:) 方法来获取对应偏移量的索引，这种方式可以避免多次调用 index(befor e:) 或 index(after:) 方法。
         */
        
        let greeting = "Guten Tag!"
        print(greeting[greeting.startIndex])
        // G
        print(greeting[greeting.index(before: greeting.endIndex)])
        // !
        print(greeting[greeting.index(after: greeting.startIndex)])
        // u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        print(greeting[index])
        // a
        
        /*
         使用 characters 属性的 indices 属性会创建一个包含全部索引的范围(Range)，用来在一个字符串中访问单 个字符。
         */
        for index in greeting.characters.indices {
            print("\(greeting[index]) ", terminator: "")
        }
        // 打印输出 "G u t e n T a g ! "
        
        
        /*插入和删除*/
        // 调用 insert(_:at:) 方法可以在一个字符串的指定索引插入一个字符，调用 insert(contentsOf:at:) 方法可 以在一个字符串的指定索引插入一个段字符串。
        var welcome = "hello"
        welcome.insert("!", at: welcome.endIndex) // welcome 变量现在等于 "hello!"
        welcome.insert(contentsOf:" there".characters, at: welcome.index(before: welcome.endIndex)) // welcome 变量现在等于 "hello there!"
        
        //调用 remove(at:) 方法可以在一个字符串的指定索引删除一个字符，调用 removeSubrange(_:) 方法可以在一 个字符串的指定索引删除一个子字符串。
        welcome.remove(at: welcome.index(before: welcome.endIndex)) // welcome 现在等于 "hello there"
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        // welcome 现在等于 "hello"
        
        /*
         注意: 您可以使用 insert(_:at:) 、 insert(contentsOf:at:) 、 remove(at:) 和 removeSubrange(_:) 方法 
         在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面，
         如上文所示是使用在 String 中，您也可以使用在 Array、Dictionary 和 Set 中。
         */
    }
    
    /// 11.比较字符串
    func compare() {
        // 字符串/字符可以用等于操作符( == )和不等于操作符( != )
        // 如果两个字符串(或者两个字符)的可扩展的字形群集是标准相等的，那就认为它们是相等的。在这个情况 下，即使可扩展的字形群集是有不同的 Unicode 标量构成的，只要它们有同样的语言意义和外观，就认为它们标 准相等。
        
        // 前缀/后缀相等
        // 通过调用字符串的 hasPrefix(_:) / hasSuffix(_:) 方法来检查字符串是否拥有特定前缀/后缀，
        // 两个方法均接收一 个 String 类型的参数，并返回一个布尔值。
        let a = "nihao ya good"
        let b = "nihao gowe"
        print(a.hasPrefix(b))
    }
    
    /// 字符串的Unicode表达形式
    func unicodeExpression() {
        /*
         当一个 Unicode 字符串被写进文本文件或者其他储存时，字符串中的 Unicode 标量会用 Unicode 定义的几种 编码格式 (encoding forms)编码。每一个字符串中的小块编码都被称 代码单元 (code units)。这些包括 UT
         F-8 编码格式(编码字符串为8位的代码单元)， UTF-16 编码格式(编码字符串位16位的代码单元)，以及 UT F-32 编码格式(编码字符串32位的代码单元)。
         */
        
        /*
         Swift 提供了几种不同的方式来访问字符串的 Unicode 表示形式。 您可以利用 for-in 来对字符串进行遍历，从 而以 Unicode 可扩展的字符群集的方式访问每一个 Character 值。
         */
        
        /*
         另外，能够以其他三种 Unicode 兼容的方式访问字符串的值:
         • UTF-8 代码单元集合 (利用字符串的 utf8 属性进行访问)
         • UTF-16 代码单元集合 (利用字符串的 utf16 属性进行访问)
         • 21位的 Unicode 标量值集合，也就是字符串的 UTF-32 编码格式 (利用字符串的 unicodeScalars 属性进行 访问)
         */
    }
    
}
