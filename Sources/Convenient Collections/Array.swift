//  Created by Roman Suvorov (kikiwora)

public extension Optional where Wrapped: Collection {
    var isEmptyOrNil: Bool { self?.isEmpty ?? true }
}

public extension Array {
    static func compact<T>(_ array: Array<T?>) -> Array<T> {
        array.compactMap { $0 }
    }

    func compact<T>() -> [T] where Element == T? {
        .compact(self)
    }

    func lazyFirst<T>() -> T? where Element == (()->T?) {
        for closure in self {
            guard let result = closure() else { continue }
            return result
        }

        return nil
    }
}

public extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}
