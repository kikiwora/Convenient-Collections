//  Created by Roman Suvorov (kikiwora)

import Foundation

// MARK: - Emptyable

public protocol Emptyable {
  static var empty: Self { get }
}

extension String: Emptyable {
  public static var empty: Self { "" }
}

extension Array: Emptyable {
  public static var empty: Self { .init() }
}

extension Dictionary: Emptyable {
  public static var empty: Self { .init() }
}

extension Set: Emptyable {
  public static var empty: Self { .init() }
}
