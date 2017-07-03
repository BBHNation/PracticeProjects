import Foundation
/// 纯函数式数据结构（Purely Functional Data Structures）：具有不可变性的高效的数据结构
/// C或C++中的指令式的数据结构往往是可变的。

// - MARK: - 二叉搜索树
public indirect enum BinarySearchTree<Element: Comparable> {
    case Leaf// 没有关联值的叶子
    case Node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)// 有关联值的节点，左子树，自己，右子树
}


// MARK: - 两个初始化方法
extension BinarySearchTree {
    public init() {
        self = BinarySearchTree.Leaf
    }
    
    public init(_ value: Element) {
        self = BinarySearchTree.Node(.Leaf, value, .Leaf)
    }
}


// MARK: - 递归方式查询二叉树中的存值的个数
extension BinarySearchTree {
    public var count: Int {
        switch self {
        case .Leaf:
            return 0
        case .Node(let left, _, let right):
            return 1 + left.count + right.count//递归调用
        }
    }
}


// MARK: - 递归方式来获取二叉树中的值的数组
extension BinarySearchTree {
    public var elements: [Element] {
        switch self {
        case .Leaf:
            return []
        case .Node(let left, let x, let right):
            return left.elements + [x] + right.elements
        }
    }
}


// MARK: - 查看是否为空
extension BinarySearchTree {
    public var isEmpty: Bool {
        if case .Leaf = self {
            return true
        }
        else {
            return false
        }
    }
}

extension Array {
    public func all(panduan: (Element)->Bool) -> Bool {
        for item in self {
            if panduan(item) {
                continue
            }
            else {
                return false
            }
        }
        return true
    }
}


// MARK: - 判断是否是二叉排序树，或者二叉搜索树
extension BinarySearchTree {
    public var isBST: Bool {
        switch self {
        case .Leaf:
            return true
        case .Node(let left, let x, let right):
            return left.elements.all(panduan: { y in y < x }) && right.elements.all(panduan: { y in y > x}) && left.isBST && right.isBST
        }
    }
}


// MARK: - 二叉搜索树查找元素
extension BinarySearchTree {
    public func contains(x: Element) -> Bool {
        switch self {
        case .Leaf:
            return false
        case .Node(_, let y, _) where y==x:
            return true
        case .Node(let left, let y, _) where y>x:
            return left.contains(x: x)
        case .Node(_, let y, let right) where y<x:
            return right.contains(x: x)
        default:
            fatalError("The impossible occurred")
        }
    }
}

// MARK: - 向二叉搜索树插入数据
extension BinarySearchTree {
    public mutating func insert(x: Element) {
        switch self {
        case .Leaf:
            self = BinarySearchTree.init(x)
        case .Node(var left, let y, var right):
            if x < y { left.insert(x: x) }
            else if x > y { right.insert(x: x) }
            self = BinarySearchTree.Node(left, y, right)//刷新一次
        }
    }
}







//************************************************************************************************************

/// 字典树的定义
/// 字典树Trie，主要用于词频统计和前缀查询,根结点没有信息，每个节点都是一个字典树
public struct Trie<Element: Hashable> {
    public var isElement: Bool
    public var children: [Element: Trie<Element>]
}


// MARK: - 初始化
extension Trie {
    public init() {
        isElement = false
        children = [:]
    }
    
    public mutating func `init`(isElement: Bool, children: [Element: Trie<Element>]) {
        self.isElement = isElement
        self.children = children
    }
}


// MARK: - 获取字典树的所有内容
extension Trie {
    var elements: [[Element]] {
        var result: [[Element]] = isElement ? [[]] : []// 如果自己是一个元素，则本元素下有可能有其他元素，所以为【【】】
        for (key, value) in children {// 遍历自己所有的子树，计算出子树的所有元素
            result += value.elements.map({ [key] + $0 })// map函数将每一个子字典树对应的charecter（也就是key）放到子树elments的首位
        }
        return result
    }
}

// MARK: - 针对Array的递归扩展
extension Array {
    var decompose: (Element, [Element])? {
        return isEmpty ? nil : (self[startIndex], Array(self.dropFirst()))// 返回数组第一个元素和数组去除第一个元素后的数组，方便递归调用，直到返回为nil
    }
}

/// 使用递归扩展来实现累加
func sum(xs: [Int]) -> Int {
    guard let (head, tail) = xs.decompose else { return 0 }
    return head + sum(xs: tail)
}


// MARK: - 给定一个由一些Element组成的数组，便利一个字典树，从而来逐一确认对应的键值是否存储在树中
// 例如"abc"传入一个包含"abc"的字典树中，则会得到true的返回
extension Trie {
    func lookup(key: [Element]) -> Bool {
        guard let (head, tail) = key.decompose else { return isElement }// 1、键组为空，返回当前节点的isElement
        guard let subtrie = children[head] else { return false }// 2、键组不为空，但是没有对应的子树，返回false
        return subtrie.lookup(key: tail)// 3、键组不为空，查询键组中第一个键对应的子树
    }
}

extension Trie {
    func withPrefix(prefix: [Element]) -> Trie<Element>? {
        guard let (head, tail) = prefix.decompose else { return self }// 1、键组为空，返回整个字典树
        guard let remainder = children[head] else { return nil }// 2、如果children中没有包含head这个键，则直接返回为空
        return remainder.withPrefix(prefix: tail)// 3、键组不为空，查询键组中第一个键对应的子树
    }
}


// MARK: - 自动补全
extension Trie {
    func autocomplete(key: [Element]) -> [[Element]] {
        return withPrefix(prefix: key)?.elements ?? []
    }
}

