//  Created by Roman Suvorov (kikiwora)

// MARK: - OrderedSet

/// An ordered set is an ordered collection of instances of `Element` in which
/// uniqueness of the objects is guaranteed.
public struct OrderedSet<E: Hashable>: Equatable, Collection {
  public typealias Element = E
  public typealias Index = Int

  #if swift(>=4.1.50)
  public typealias Indices = Range<Int>
  #else
  public typealias Indices = CountableRange<Int>
  #endif

  private var array: [Element]
  private var set: Set<Element>

  /// Creates an empty ordered set.
  public init() {
    array = []
    set = Set()
  }

  /// Creates an ordered set with the contents of `array`.
  ///
  /// If an element occurs more than once in `element`, only the first one
  /// will be included.
  public init(_ array: [Element]) {
    self.init()
    for element in array {
      append(element)
    }
  }

  // MARK: - Interfaces

  /// The number of elements the ordered set stores.
  public var count: Int { array.count }

  /// Returns `true` if the set is empty.
  public var isEmpty: Bool { array.isEmpty }

  /// Returns the contents of the set as an Array.
  public var contents: [Element] { array }

  /// Returns the contents of the set as a Set.
  public var unique: Set<Element> { self.set }

  /// Returns `true` if the ordered set contains `member`.
  public func contains(_ member: Element) -> Bool {
    set.contains(member)
  }

  /// Adds an element to the ordered set.
  ///
  /// If it already contains the element, then the set is unchanged.
  ///
  /// - returns: True if the item was inserted.
  @discardableResult
  public mutating func append(_ newElement: Element) -> Bool {
    let inserted = set.insert(newElement).inserted
    if inserted {
      array.append(newElement)
    }
    return inserted
  }

  /// Remove and return the element at the beginning of the ordered set.
  @discardableResult
  public mutating func removeFirst() -> Element {
    let firstElement = array.removeFirst()
    set.remove(firstElement)
    return firstElement
  }

  @discardableResult
  public mutating func removeFirst(_ batchSize: Int) -> [Element] {
    guard batchSize > .zero else { return .empty }

    let batchToRemove = Array(array.prefix(batchSize))
    array.removeFirst(batchSize)
    set.subtract(Set(batchToRemove))
    return batchToRemove
  }

  /// Remove and return the element at the end of the ordered set.
  @discardableResult
  public mutating func removeLast() -> Element {
    let lastElement = array.removeLast()
    set.remove(lastElement)
    return lastElement
  }

  /// Remove all elements.
  public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    array.removeAll(keepingCapacity: keepCapacity)
    set.removeAll(keepingCapacity: keepCapacity)
  }

  /// Inserts new unique contents of `Array` into the `OrderedSet`
  /// - Parameter array: `Array` of contents to insert
  public mutating func insert(_ array: [Element]) {
    array.forEach { append($0) }
  }
}

// MARK: - ExpressibleByArrayLiteral

extension OrderedSet: ExpressibleByArrayLiteral {
  /// Create an instance initialized with `elements`.
  ///
  /// If an element occurs more than once in `element`, only the first one
  /// will be included.
  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }
}

// MARK: - RandomAccessCollection

extension OrderedSet: RandomAccessCollection {
  public var startIndex: Int { contents.startIndex }
  public var endIndex: Int { contents.endIndex }
  public subscript(index: Int) -> Element {
    contents[index]
  }
}

public func == <T>(lhs: OrderedSet<T>, rhs: OrderedSet<T>) -> Bool {
  lhs.contents == rhs.contents
}

// MARK: - Hashable

extension OrderedSet: Hashable where Element: Hashable {}

public extension OrderedSet {
  mutating func remove(_ element: Element) {
    array.remove(element)
    set.remove(element)
  }
}

// MARK: - Encodable

extension OrderedSet: Encodable where E: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(contents)
  }
}

// MARK: - Decodable

extension OrderedSet: Decodable where E: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let array = try container.decode([E].self)
    self.init(array)
  }
}
