//  This file was automatically generated and should not be edited.

import Apollo

/// Different periods allowed for bitcoin price index
public enum CryptoPeriodTypes: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case current
  case day
  case week
  case month
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "current": self = .current
      case "day": self = .day
      case "week": self = .week
      case "month": self = .month
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .current: return "current"
      case .day: return "day"
      case .week: return "week"
      case .month: return "month"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: CryptoPeriodTypes, rhs: CryptoPeriodTypes) -> Bool {
    switch (lhs, rhs) {
      case (.current, .current): return true
      case (.day, .day): return true
      case (.week, .week): return true
      case (.month, .month): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// Supported cryptos
public enum Cryptocurrency: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case bitcoin
  case litecoin
  case ethereum
  case bitcoinCash
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "bitcoin": self = .bitcoin
      case "litecoin": self = .litecoin
      case "ethereum": self = .ethereum
      case "bitcoin_cash": self = .bitcoinCash
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .bitcoin: return "bitcoin"
      case .litecoin: return "litecoin"
      case .ethereum: return "ethereum"
      case .bitcoinCash: return "bitcoin_cash"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Cryptocurrency, rhs: Cryptocurrency) -> Bool {
    switch (lhs, rhs) {
      case (.bitcoin, .bitcoin): return true
      case (.litecoin, .litecoin): return true
      case (.ethereum, .ethereum): return true
      case (.bitcoinCash, .bitcoinCash): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class CryptoPriceIndexQuery: GraphQLQuery {
  public static let operationString =
    "query CryptoPriceIndex($period: CryptoPeriodTypes, $cryptocurrency: Cryptocurrency) {\n  cryptoPriceIndex(period: $period, cryptocurrency: $cryptocurrency) {\n    __typename\n    values {\n      __typename\n      date\n      rate\n    }\n  }\n}"

  public var period: CryptoPeriodTypes?
  public var cryptocurrency: Cryptocurrency?

  public init(period: CryptoPeriodTypes? = nil, cryptocurrency: Cryptocurrency? = nil) {
    self.period = period
    self.cryptocurrency = cryptocurrency
  }

  public var variables: GraphQLMap? {
    return ["period": period, "cryptocurrency": cryptocurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("cryptoPriceIndex", arguments: ["period": GraphQLVariable("period"), "cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(CryptoPriceIndex.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(cryptoPriceIndex: CryptoPriceIndex? = nil) {
      self.init(snapshot: ["__typename": "Query", "cryptoPriceIndex": cryptoPriceIndex.flatMap { (value: CryptoPriceIndex) -> Snapshot in value.snapshot }])
    }

    public var cryptoPriceIndex: CryptoPriceIndex? {
      get {
        return (snapshot["cryptoPriceIndex"] as? Snapshot).flatMap { CryptoPriceIndex(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "cryptoPriceIndex")
      }
    }

    public struct CryptoPriceIndex: GraphQLSelectionSet {
      public static let possibleTypes = ["CryptoPriceIndex"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("values", type: .list(.object(Value.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(values: [Value?]? = nil) {
        self.init(snapshot: ["__typename": "CryptoPriceIndex", "values": values.flatMap { (value: [Value?]) -> [Snapshot?] in value.map { (value: Value?) -> Snapshot? in value.flatMap { (value: Value) -> Snapshot in value.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var values: [Value?]? {
        get {
          return (snapshot["values"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Value?] in value.map { (value: Snapshot?) -> Value? in value.flatMap { (value: Snapshot) -> Value in Value(snapshot: value) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { (value: [Value?]) -> [Snapshot?] in value.map { (value: Value?) -> Snapshot? in value.flatMap { (value: Value) -> Snapshot in value.snapshot } } }, forKey: "values")
        }
      }

      public struct Value: GraphQLSelectionSet {
        public static let possibleTypes = ["CryptoPriceIndexCoordinates"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("date", type: .nonNull(.scalar(String.self))),
          GraphQLField("rate", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(date: String, rate: String? = nil) {
          self.init(snapshot: ["__typename": "CryptoPriceIndexCoordinates", "date": date, "rate": rate])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var date: String {
          get {
            return snapshot["date"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "date")
          }
        }

        public var rate: String? {
          get {
            return snapshot["rate"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "rate")
          }
        }
      }
    }
  }
}