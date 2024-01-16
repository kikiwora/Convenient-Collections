//  Created by Roman Suvorov (kikiwora)

import Foundation

public extension Numeric {
  var isZero: Bool { self == .zero }
  var isNotZero: Bool { !isZero }
}

public extension Numeric where Self: Comparable {
  var isPositive: Bool { self > .zero }
  var isNegative: Bool { self < .zero }
}
