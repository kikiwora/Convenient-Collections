//  Created by Roman Suvorov (kikiwora)

import Foundation

public extension Optional {
  var isNil: Bool { switch self {
  case .some: false
  case .none: true
  }}

  var isNotNil: Bool { switch self {
  case .some: true
  case .none: false
  }}
}

public extension Optional where Wrapped: Collection {
  var isEmptyOrNil: Bool { self?.isEmpty ?? true }
  var isNotEmptyNorNil: Bool { !isEmptyOrNil }
}

public extension Optional where Wrapped: Collection & Equatable {
  func isEqualOrEmpty(_ other: Self) -> Bool {
    if self == nil, other?.isEmpty ?? false {
      true
    } else if self?.isEmpty ?? false, other == nil {
      true
    } else {
      self == other
    }
  }
}

public extension Numeric? {
  var isZeroOrNil: Bool { self?.isZero ?? true }
  var isNotZeroNorNil: Bool { !isZeroOrNil }
}
