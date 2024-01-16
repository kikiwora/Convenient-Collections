//  Created by Roman Suvorov (kikiwora)

import Foundation

public extension Collection {
  var isNotEmpty: Bool { !isEmpty }

  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

public extension Optional where Wrapped: Collection {
  var nilIfEmpty: Self {
    isEmptyOrNil ? nil : self
  }
}

public extension Optional where Wrapped: Collection & Emptyable {
  var emptyIfNil: Wrapped {
    if let self {
      self
    } else {
      .empty
    }
  }
}

@inlinable public func unify<T>(min: T, value: T, max: T) -> T where T: Comparable {
  Swift.min(max, Swift.max(min, value))
}
