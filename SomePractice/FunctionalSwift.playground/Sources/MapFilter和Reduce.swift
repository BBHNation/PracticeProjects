import Foundation

extension Array {
    
    /// 查找
    ///
    /// - Parameter transform: 变换的函数
    /// - Returns: 返回已经变换好的集合
    /// - Throws: 抛出错误
    func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result = [T]()
        for x in self {
            result.append(try transform(x))
        }
        return result
    }
    
    
    /// 筛选
    ///
    /// - Parameter isIncluded: 是否包含的函数
    /// - Returns: 返回已经筛选好满足条件的集合
    /// - Throws: 抛出错误
    func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        var result = [Element]()
        for x in self {
            if try isIncluded(x) {
                result.append(x)
            }
        }
        return result
    }
    
    
    /// 累计处理元素
    ///
    /// - Parameters:
    ///   - initialResult: 初始化的最终结果
    ///   - nextPartialResult: 针对下一个内容的操作
    /// - Returns: 返回处理好的最终结果
    /// - Throws: 抛出错误
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result {
        var result = initialResult
        for x in self {
            result = try nextPartialResult(result, x)
        }
        return result
    }
}
