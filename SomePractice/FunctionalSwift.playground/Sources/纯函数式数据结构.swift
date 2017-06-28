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
        swit ch self {
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

