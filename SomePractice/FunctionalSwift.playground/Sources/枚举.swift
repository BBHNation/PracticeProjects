import Foundation

/// 描述Encoding的类型
enum Encoding {
    case ASCII
    case NEXTSTEP
    case JapaneseEUC
    case UTF8
}



// MARK: - 扩展一个属性，来根据自己的类型获取相应的String.Encoding
extension Encoding {
    var nsStringEncoding : String.Encoding {
        switch self {
        case .ASCII:
            return String.Encoding.ascii
        case .NEXTSTEP:
            return String.Encoding.nextstep
        case .JapaneseEUC:
            return String.Encoding.japaneseEUC
        case .UTF8:
            return String.Encoding.utf8
        }
    }
}


// MARK: - 扩展一个根据String.Encoding来初始化的方法
extension Encoding {
    init?(enc: String.Encoding) {
        switch enc {
        case String.Encoding.ascii:
            self = .ASCII
        case String.Encoding.japaneseEUC:
            self = .JapaneseEUC
        case String.Encoding.nextstep:
            self = .NEXTSTEP
        case String.Encoding.utf8:
            self = .UTF8
        default:
            return nil
        }
    }
}







/// ***********************************************************8
enum LookupError: Error {
    case CapitalNotFound
    case PopulationNotFound
}

enum PopulationResult {
    case Success(Int)
    case Error(LookupError)
}

var exampleSuccess: PopulationResult = .Success(100)


/// 处理枚举类型
///
/// - Parameter result: 传入一个枚举类型
func example(result: PopulationResult) {
    switch result {
    case .Success(let i):
        print(i)
    case .Error(let err):
        print(err.localizedDescription)
    }
}

enum Result<T> {
    case Success(T)
    case Error(Error)
}






