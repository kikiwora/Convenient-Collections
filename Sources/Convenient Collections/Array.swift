//  Created by Roman Suvorov (kikiwora)

import Foundation

public extension Array {
  static func compact<T>(_ array: [T?]) -> [T] {
    array.compactMap { $0 }
  }

  func compact<T>() -> [T] where Element == T? {
    .compact(self)
  }

  func find(_ condition: (Element) -> Bool) -> Element? {
    for element in self {
      if condition(element) {
        return element
      }
    }
    return nil
  }

  func lift(_ index: Int) -> Element? {
    if index < 0 || index >= count {
      return nil
    }
    return self[index]
  }

  mutating func removeFirst(where shouldRemove: (Element) -> Bool) {
    for (index, item) in enumerated() {
      if shouldRemove(item) {
        remove(at: index)
        return
      }
    }
  }

  func lazyFirst<T>() -> T? where Element == (() -> T?) {
    for closure in self {
      guard let result = closure() else { continue }
      return result
    }

    return nil
  }

  func tail(startingAt index: Int) -> Self {
    Array(suffix(from: index))
  }
}

public extension Array where Element: Equatable {
  /// Works correctly only for arrays with unique elements
  func next(after element: Element) -> Element? {
    guard let index = firstIndex(of: element) else { return nil }
    return lift(index + 1)
  }

  /// Works correctly only for arrays with unique elements
  func previous(before element: Element) -> Element? {
    guard let index = firstIndex(of: element) else { return nil }
    return lift(index - 1)
  }

  mutating func remove(_ element: Element) {
    if let index = firstIndex(of: element) {
      remove(at: index)
    }
  }
}
