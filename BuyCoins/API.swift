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

/// Possible types for 2FA
public enum TwoFactorType: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case sms
  case googleAuthenticator
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "sms": self = .sms
      case "google_authenticator": self = .googleAuthenticator
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .sms: return "sms"
      case .googleAuthenticator: return "google_authenticator"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: TwoFactorType, rhs: TwoFactorType) -> Bool {
    switch (lhs, rhs) {
      case (.sms, .sms): return true
      case (.googleAuthenticator, .googleAuthenticator): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

/// Possible types of transactions
public enum TransactionType: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case offchain
  case onchain
  case escrow
  case promo
  case buycoinsSell
  case buycoinsBuy
  case buycoinsChange
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "offchain": self = .offchain
      case "onchain": self = .onchain
      case "escrow": self = .escrow
      case "promo": self = .promo
      case "buycoins_sell": self = .buycoinsSell
      case "buycoins_buy": self = .buycoinsBuy
      case "buycoins_change": self = .buycoinsChange
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .offchain: return "offchain"
      case .onchain: return "onchain"
      case .escrow: return "escrow"
      case .promo: return "promo"
      case .buycoinsSell: return "buycoins_sell"
      case .buycoinsBuy: return "buycoins_buy"
      case .buycoinsChange: return "buycoins_change"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: TransactionType, rhs: TransactionType) -> Bool {
    switch (lhs, rhs) {
      case (.offchain, .offchain): return true
      case (.onchain, .onchain): return true
      case (.escrow, .escrow): return true
      case (.promo, .promo): return true
      case (.buycoinsSell, .buycoinsSell): return true
      case (.buycoinsBuy, .buycoinsBuy): return true
      case (.buycoinsChange, .buycoinsChange): return true
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

public final class WalletQuery: GraphQLQuery {
  public static let operationString =
    "query Wallet {\n  currentUser {\n    __typename\n    wallets {\n      __typename\n      confirmedBalance\n      cryptocurrency\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("currentUser", type: .object(CurrentUser.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(currentUser: CurrentUser? = nil) {
      self.init(snapshot: ["__typename": "Query", "currentUser": currentUser.flatMap { (value: CurrentUser) -> Snapshot in value.snapshot }])
    }

    public var currentUser: CurrentUser? {
      get {
        return (snapshot["currentUser"] as? Snapshot).flatMap { CurrentUser(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "currentUser")
      }
    }

    public struct CurrentUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("wallets", type: .list(.object(Wallet.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(wallets: [Wallet?]? = nil) {
        self.init(snapshot: ["__typename": "User", "wallets": wallets.flatMap { (value: [Wallet?]) -> [Snapshot?] in value.map { (value: Wallet?) -> Snapshot? in value.flatMap { (value: Wallet) -> Snapshot in value.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var wallets: [Wallet?]? {
        get {
          return (snapshot["wallets"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Wallet?] in value.map { (value: Snapshot?) -> Wallet? in value.flatMap { (value: Snapshot) -> Wallet in Wallet(snapshot: value) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { (value: [Wallet?]) -> [Snapshot?] in value.map { (value: Wallet?) -> Snapshot? in value.flatMap { (value: Wallet) -> Snapshot in value.snapshot } } }, forKey: "wallets")
        }
      }

      public struct Wallet: GraphQLSelectionSet {
        public static let possibleTypes = ["Wallet"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("confirmedBalance", type: .scalar(String.self)),
          GraphQLField("cryptocurrency", type: .scalar(Cryptocurrency.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(confirmedBalance: String? = nil, cryptocurrency: Cryptocurrency? = nil) {
          self.init(snapshot: ["__typename": "Wallet", "confirmedBalance": confirmedBalance, "cryptocurrency": cryptocurrency])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var confirmedBalance: String? {
          get {
            return snapshot["confirmedBalance"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "confirmedBalance")
          }
        }

        public var cryptocurrency: Cryptocurrency? {
          get {
            return snapshot["cryptocurrency"] as? Cryptocurrency
          }
          set {
            snapshot.updateValue(newValue, forKey: "cryptocurrency")
          }
        }
      }
    }
  }
}

public final class SendCoinMutation: GraphQLMutation {
  public static let operationString =
    "mutation SendCoin($amount: BigDecimal, $cryptocurrency: Cryptocurrency, $address: String!, $otp: String) {\n  sendCoins(amount: $amount, cryptocurrency: $cryptocurrency, address: $address, otp: $otp) {\n    __typename\n    initiated\n  }\n}"

  public var amount: String?
  public var cryptocurrency: Cryptocurrency?
  public var address: String
  public var otp: String?

  public init(amount: String? = nil, cryptocurrency: Cryptocurrency? = nil, address: String, otp: String? = nil) {
    self.amount = amount
    self.cryptocurrency = cryptocurrency
    self.address = address
    self.otp = otp
  }

  public var variables: GraphQLMap? {
    return ["amount": amount, "cryptocurrency": cryptocurrency, "address": address, "otp": otp]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("sendCoins", arguments: ["amount": GraphQLVariable("amount"), "cryptocurrency": GraphQLVariable("cryptocurrency"), "address": GraphQLVariable("address"), "otp": GraphQLVariable("otp")], type: .object(SendCoin.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(sendCoins: SendCoin? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "sendCoins": sendCoins.flatMap { (value: SendCoin) -> Snapshot in value.snapshot }])
    }

    public var sendCoins: SendCoin? {
      get {
        return (snapshot["sendCoins"] as? Snapshot).flatMap { SendCoin(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "sendCoins")
      }
    }

    public struct SendCoin: GraphQLSelectionSet {
      public static let possibleTypes = ["TransferInitiated"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("initiated", type: .nonNull(.scalar(Bool.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(initiated: Bool) {
        self.init(snapshot: ["__typename": "TransferInitiated", "initiated": initiated])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var initiated: Bool {
        get {
          return snapshot["initiated"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "initiated")
        }
      }
    }
  }
}

public final class SendOtpMutation: GraphQLMutation {
  public static let operationString =
    "mutation SendOTP($call: Boolean) {\n  sendOtp(call: $call) {\n    __typename\n    username\n  }\n}"

  public var call: Bool?

  public init(call: Bool? = nil) {
    self.call = call
  }

  public var variables: GraphQLMap? {
    return ["call": call]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("sendOtp", arguments: ["call": GraphQLVariable("call")], type: .object(SendOtp.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(sendOtp: SendOtp? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "sendOtp": sendOtp.flatMap { (value: SendOtp) -> Snapshot in value.snapshot }])
    }

    public var sendOtp: SendOtp? {
      get {
        return (snapshot["sendOtp"] as? Snapshot).flatMap { SendOtp(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "sendOtp")
      }
    }

    public struct SendOtp: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(username: String) {
        self.init(snapshot: ["__typename": "User", "username": username])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var username: String {
        get {
          return snapshot["username"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "username")
        }
      }
    }
  }
}

public final class NetworkFeeQuery: GraphQLQuery {
  public static let operationString =
    "query NetworkFee($amount: BigDecimal!, $address: String!, $cryptocurrency: Cryptocurrency) {\n  getEstimatedNetworkFee(amount: $amount, address: $address, cryptocurrency: $cryptocurrency) {\n    __typename\n    estimatedFee\n    total\n  }\n}"

  public var amount: String
  public var address: String
  public var cryptocurrency: Cryptocurrency?

  public init(amount: String, address: String, cryptocurrency: Cryptocurrency? = nil) {
    self.amount = amount
    self.address = address
    self.cryptocurrency = cryptocurrency
  }

  public var variables: GraphQLMap? {
    return ["amount": amount, "address": address, "cryptocurrency": cryptocurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getEstimatedNetworkFee", arguments: ["amount": GraphQLVariable("amount"), "address": GraphQLVariable("address"), "cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(GetEstimatedNetworkFee.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getEstimatedNetworkFee: GetEstimatedNetworkFee? = nil) {
      self.init(snapshot: ["__typename": "Query", "getEstimatedNetworkFee": getEstimatedNetworkFee.flatMap { (value: GetEstimatedNetworkFee) -> Snapshot in value.snapshot }])
    }

    public var getEstimatedNetworkFee: GetEstimatedNetworkFee? {
      get {
        return (snapshot["getEstimatedNetworkFee"] as? Snapshot).flatMap { GetEstimatedNetworkFee(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getEstimatedNetworkFee")
      }
    }

    public struct GetEstimatedNetworkFee: GraphQLSelectionSet {
      public static let possibleTypes = ["EstimatedFee"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("estimatedFee", type: .scalar(String.self)),
        GraphQLField("total", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(estimatedFee: String? = nil, total: String? = nil) {
        self.init(snapshot: ["__typename": "EstimatedFee", "estimatedFee": estimatedFee, "total": total])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var estimatedFee: String? {
        get {
          return snapshot["estimatedFee"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "estimatedFee")
        }
      }

      public var total: String? {
        get {
          return snapshot["total"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "total")
        }
      }
    }
  }
}

public final class OtpStatusQuery: GraphQLQuery {
  public static let operationString =
    "query OTPStatus {\n  currentUser {\n    __typename\n    phone\n    twoFactorAuthentication\n    twoFactorType\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("currentUser", type: .object(CurrentUser.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(currentUser: CurrentUser? = nil) {
      self.init(snapshot: ["__typename": "Query", "currentUser": currentUser.flatMap { (value: CurrentUser) -> Snapshot in value.snapshot }])
    }

    public var currentUser: CurrentUser? {
      get {
        return (snapshot["currentUser"] as? Snapshot).flatMap { CurrentUser(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "currentUser")
      }
    }

    public struct CurrentUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("phone", type: .scalar(String.self)),
        GraphQLField("twoFactorAuthentication", type: .scalar(Bool.self)),
        GraphQLField("twoFactorType", type: .scalar(TwoFactorType.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(phone: String? = nil, twoFactorAuthentication: Bool? = nil, twoFactorType: TwoFactorType? = nil) {
        self.init(snapshot: ["__typename": "User", "phone": phone, "twoFactorAuthentication": twoFactorAuthentication, "twoFactorType": twoFactorType])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var phone: String? {
        get {
          return snapshot["phone"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "phone")
        }
      }

      public var twoFactorAuthentication: Bool? {
        get {
          return snapshot["twoFactorAuthentication"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "twoFactorAuthentication")
        }
      }

      public var twoFactorType: TwoFactorType? {
        get {
          return snapshot["twoFactorType"] as? TwoFactorType
        }
        set {
          snapshot.updateValue(newValue, forKey: "twoFactorType")
        }
      }
    }
  }
}

public final class CardsQuery: GraphQLQuery {
  public static let operationString =
    "query Cards {\n  currentUser {\n    __typename\n    cards {\n      __typename\n      card_type\n      last4\n      id\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("currentUser", type: .object(CurrentUser.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(currentUser: CurrentUser? = nil) {
      self.init(snapshot: ["__typename": "Query", "currentUser": currentUser.flatMap { (value: CurrentUser) -> Snapshot in value.snapshot }])
    }

    public var currentUser: CurrentUser? {
      get {
        return (snapshot["currentUser"] as? Snapshot).flatMap { CurrentUser(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "currentUser")
      }
    }

    public struct CurrentUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("cards", type: .list(.object(Card.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(cards: [Card?]? = nil) {
        self.init(snapshot: ["__typename": "User", "cards": cards.flatMap { (value: [Card?]) -> [Snapshot?] in value.map { (value: Card?) -> Snapshot? in value.flatMap { (value: Card) -> Snapshot in value.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var cards: [Card?]? {
        get {
          return (snapshot["cards"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Card?] in value.map { (value: Snapshot?) -> Card? in value.flatMap { (value: Snapshot) -> Card in Card(snapshot: value) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { (value: [Card?]) -> [Snapshot?] in value.map { (value: Card?) -> Snapshot? in value.flatMap { (value: Card) -> Snapshot in value.snapshot } } }, forKey: "cards")
        }
      }

      public struct Card: GraphQLSelectionSet {
        public static let possibleTypes = ["Card"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("card_type", type: .nonNull(.scalar(String.self))),
          GraphQLField("last4", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(cardType: String, last4: String, id: GraphQLID) {
          self.init(snapshot: ["__typename": "Card", "card_type": cardType, "last4": last4, "id": id])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var cardType: String {
          get {
            return snapshot["card_type"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "card_type")
          }
        }

        public var last4: String {
          get {
            return snapshot["last4"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "last4")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class CoinPriceQuery: GraphQLQuery {
  public static let operationString =
    "query CoinPrice($cryptocurrency: Cryptocurrency!) {\n  buycoinsPrices(cryptocurrency: $cryptocurrency) {\n    __typename\n    buyPricePerCoin\n    sellPricePerCoin\n    maxBuy\n    maxSell\n  }\n}"

  public var cryptocurrency: Cryptocurrency

  public init(cryptocurrency: Cryptocurrency) {
    self.cryptocurrency = cryptocurrency
  }

  public var variables: GraphQLMap? {
    return ["cryptocurrency": cryptocurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("buycoinsPrices", arguments: ["cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(BuycoinsPrice.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(buycoinsPrices: BuycoinsPrice? = nil) {
      self.init(snapshot: ["__typename": "Query", "buycoinsPrices": buycoinsPrices.flatMap { (value: BuycoinsPrice) -> Snapshot in value.snapshot }])
    }

    public var buycoinsPrices: BuycoinsPrice? {
      get {
        return (snapshot["buycoinsPrices"] as? Snapshot).flatMap { BuycoinsPrice(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "buycoinsPrices")
      }
    }

    public struct BuycoinsPrice: GraphQLSelectionSet {
      public static let possibleTypes = ["BuycoinsPrice"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("buyPricePerCoin", type: .scalar(String.self)),
        GraphQLField("sellPricePerCoin", type: .scalar(String.self)),
        GraphQLField("maxBuy", type: .scalar(String.self)),
        GraphQLField("maxSell", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(buyPricePerCoin: String? = nil, sellPricePerCoin: String? = nil, maxBuy: String? = nil, maxSell: String? = nil) {
        self.init(snapshot: ["__typename": "BuycoinsPrice", "buyPricePerCoin": buyPricePerCoin, "sellPricePerCoin": sellPricePerCoin, "maxBuy": maxBuy, "maxSell": maxSell])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Price per coin in naira, that users can buy from us
      public var buyPricePerCoin: String? {
        get {
          return snapshot["buyPricePerCoin"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "buyPricePerCoin")
        }
      }

      /// Price per coin in naira, that users can sell to us
      public var sellPricePerCoin: String? {
        get {
          return snapshot["sellPricePerCoin"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "sellPricePerCoin")
        }
      }

      /// The maximum amount of coin that can be bought with the USD we have.
      public var maxBuy: String? {
        get {
          return snapshot["maxBuy"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "maxBuy")
        }
      }

      /// The maximum amount of coin that can be sold based on the Naira we can currently send to users
      public var maxSell: String? {
        get {
          return snapshot["maxSell"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "maxSell")
        }
      }
    }
  }
}

public final class WalletAddressQuery: GraphQLQuery {
  public static let operationString =
    "query WalletAddress($cryptocurrency: Cryptocurrency) {\n  getAddress(cryptocurrency: $cryptocurrency) {\n    __typename\n    address\n    cryptocurrency\n  }\n}"

  public var cryptocurrency: Cryptocurrency?

  public init(cryptocurrency: Cryptocurrency? = nil) {
    self.cryptocurrency = cryptocurrency
  }

  public var variables: GraphQLMap? {
    return ["cryptocurrency": cryptocurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getAddress", arguments: ["cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(GetAddress.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getAddress: GetAddress? = nil) {
      self.init(snapshot: ["__typename": "Query", "getAddress": getAddress.flatMap { (value: GetAddress) -> Snapshot in value.snapshot }])
    }

    public var getAddress: GetAddress? {
      get {
        return (snapshot["getAddress"] as? Snapshot).flatMap { GetAddress(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getAddress")
      }
    }

    public struct GetAddress: GraphQLSelectionSet {
      public static let possibleTypes = ["Address"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("cryptocurrency", type: .scalar(Cryptocurrency.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(address: String, cryptocurrency: Cryptocurrency? = nil) {
        self.init(snapshot: ["__typename": "Address", "address": address, "cryptocurrency": cryptocurrency])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      public var cryptocurrency: Cryptocurrency? {
        get {
          return snapshot["cryptocurrency"] as? Cryptocurrency
        }
        set {
          snapshot.updateValue(newValue, forKey: "cryptocurrency")
        }
      }
    }
  }
}

public final class WalletTransactionsQuery: GraphQLQuery {
  public static let operationString =
    "query WalletTransactions($last: Int = 30, $cryptocurrency: Cryptocurrency!) {\n  cryptoPriceIndex(period: current, cryptocurrency: $cryptocurrency) {\n    __typename\n    values {\n      __typename\n      rate\n      date\n    }\n  }\n  currentUser {\n    __typename\n    wallet(cryptocurrency: $cryptocurrency) {\n      __typename\n      confirmedBalance\n      unconfirmedBalance\n      updatedAt\n      cryptocurrency\n    }\n    cryptoTransactions(last: $last, cryptocurrency: $cryptocurrency) {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          amount\n          createdAt\n          direction\n          type\n          confirmed\n          cryptocurrency\n        }\n      }\n    }\n  }\n}"

  public var last: Int?
  public var cryptocurrency: Cryptocurrency

  public init(last: Int? = nil, cryptocurrency: Cryptocurrency) {
    self.last = last
    self.cryptocurrency = cryptocurrency
  }

  public var variables: GraphQLMap? {
    return ["last": last, "cryptocurrency": cryptocurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("cryptoPriceIndex", arguments: ["period": "current", "cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(CryptoPriceIndex.selections)),
      GraphQLField("currentUser", type: .object(CurrentUser.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(cryptoPriceIndex: CryptoPriceIndex? = nil, currentUser: CurrentUser? = nil) {
      self.init(snapshot: ["__typename": "Query", "cryptoPriceIndex": cryptoPriceIndex.flatMap { (value: CryptoPriceIndex) -> Snapshot in value.snapshot }, "currentUser": currentUser.flatMap { (value: CurrentUser) -> Snapshot in value.snapshot }])
    }

    public var cryptoPriceIndex: CryptoPriceIndex? {
      get {
        return (snapshot["cryptoPriceIndex"] as? Snapshot).flatMap { CryptoPriceIndex(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "cryptoPriceIndex")
      }
    }

    public var currentUser: CurrentUser? {
      get {
        return (snapshot["currentUser"] as? Snapshot).flatMap { CurrentUser(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "currentUser")
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
          GraphQLField("rate", type: .scalar(String.self)),
          GraphQLField("date", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(rate: String? = nil, date: String) {
          self.init(snapshot: ["__typename": "CryptoPriceIndexCoordinates", "rate": rate, "date": date])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
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

        public var date: String {
          get {
            return snapshot["date"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "date")
          }
        }
      }
    }

    public struct CurrentUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("wallet", arguments: ["cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(Wallet.selections)),
        GraphQLField("cryptoTransactions", arguments: ["last": GraphQLVariable("last"), "cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(CryptoTransaction.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(wallet: Wallet? = nil, cryptoTransactions: CryptoTransaction? = nil) {
        self.init(snapshot: ["__typename": "User", "wallet": wallet.flatMap { (value: Wallet) -> Snapshot in value.snapshot }, "cryptoTransactions": cryptoTransactions.flatMap { (value: CryptoTransaction) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var wallet: Wallet? {
        get {
          return (snapshot["wallet"] as? Snapshot).flatMap { Wallet(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "wallet")
        }
      }

      public var cryptoTransactions: CryptoTransaction? {
        get {
          return (snapshot["cryptoTransactions"] as? Snapshot).flatMap { CryptoTransaction(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "cryptoTransactions")
        }
      }

      public struct Wallet: GraphQLSelectionSet {
        public static let possibleTypes = ["Wallet"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("confirmedBalance", type: .scalar(String.self)),
          GraphQLField("unconfirmedBalance", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .nonNull(.scalar(Int.self))),
          GraphQLField("cryptocurrency", type: .scalar(Cryptocurrency.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(confirmedBalance: String? = nil, unconfirmedBalance: String? = nil, updatedAt: Int, cryptocurrency: Cryptocurrency? = nil) {
          self.init(snapshot: ["__typename": "Wallet", "confirmedBalance": confirmedBalance, "unconfirmedBalance": unconfirmedBalance, "updatedAt": updatedAt, "cryptocurrency": cryptocurrency])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var confirmedBalance: String? {
          get {
            return snapshot["confirmedBalance"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "confirmedBalance")
          }
        }

        public var unconfirmedBalance: String? {
          get {
            return snapshot["unconfirmedBalance"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "unconfirmedBalance")
          }
        }

        public var updatedAt: Int {
          get {
            return snapshot["updatedAt"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var cryptocurrency: Cryptocurrency? {
          get {
            return snapshot["cryptocurrency"] as? Cryptocurrency
          }
          set {
            snapshot.updateValue(newValue, forKey: "cryptocurrency")
          }
        }
      }

      public struct CryptoTransaction: GraphQLSelectionSet {
        public static let possibleTypes = ["CryptoTransactionConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil) {
          self.init(snapshot: ["__typename": "CryptoTransactionConnection", "edges": edges.flatMap { (value: [Edge?]) -> [Snapshot?] in value.map { (value: Edge?) -> Snapshot? in value.flatMap { (value: Edge) -> Snapshot in value.snapshot } } }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Edge?] in value.map { (value: Snapshot?) -> Edge? in value.flatMap { (value: Snapshot) -> Edge in Edge(snapshot: value) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { (value: [Edge?]) -> [Snapshot?] in value.map { (value: Edge?) -> Snapshot? in value.flatMap { (value: Edge) -> Snapshot in value.snapshot } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["CryptoTransactionEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "CryptoTransactionEdge", "node": node.flatMap { (value: Node) -> Snapshot in value.snapshot }])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"] as? Snapshot).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["CryptoTransaction"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("amount", type: .scalar(String.self)),
              GraphQLField("createdAt", type: .nonNull(.scalar(Int.self))),
              GraphQLField("direction", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .nonNull(.scalar(TransactionType.self))),
              GraphQLField("confirmed", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("cryptocurrency", type: .scalar(Cryptocurrency.self)),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(amount: String? = nil, createdAt: Int, direction: String, type: TransactionType, confirmed: Bool, cryptocurrency: Cryptocurrency? = nil) {
              self.init(snapshot: ["__typename": "CryptoTransaction", "amount": amount, "createdAt": createdAt, "direction": direction, "type": type, "confirmed": confirmed, "cryptocurrency": cryptocurrency])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var amount: String? {
              get {
                return snapshot["amount"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "amount")
              }
            }

            public var createdAt: Int {
              get {
                return snapshot["createdAt"]! as! Int
              }
              set {
                snapshot.updateValue(newValue, forKey: "createdAt")
              }
            }

            public var direction: String {
              get {
                return snapshot["direction"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "direction")
              }
            }

            public var type: TransactionType {
              get {
                return snapshot["type"]! as! TransactionType
              }
              set {
                snapshot.updateValue(newValue, forKey: "type")
              }
            }

            public var confirmed: Bool {
              get {
                return snapshot["confirmed"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "confirmed")
              }
            }

            public var cryptocurrency: Cryptocurrency? {
              get {
                return snapshot["cryptocurrency"] as? Cryptocurrency
              }
              set {
                snapshot.updateValue(newValue, forKey: "cryptocurrency")
              }
            }
          }
        }
      }
    }
  }
}

public final class WalletBalanceQuery: GraphQLQuery {
  public static let operationString =
    "query WalletBalance($cryptocurrency: Cryptocurrency!) {\n  currentUser {\n    __typename\n    wallet(cryptocurrency: $cryptocurrency) {\n      __typename\n      confirmedBalance\n      unconfirmedBalance\n      updatedAt\n      cryptocurrency\n    }\n  }\n}"

  public var cryptocurrency: Cryptocurrency

  public init(cryptocurrency: Cryptocurrency) {
    self.cryptocurrency = cryptocurrency
  }

  public var variables: GraphQLMap? {
    return ["cryptocurrency": cryptocurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("currentUser", type: .object(CurrentUser.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(currentUser: CurrentUser? = nil) {
      self.init(snapshot: ["__typename": "Query", "currentUser": currentUser.flatMap { (value: CurrentUser) -> Snapshot in value.snapshot }])
    }

    public var currentUser: CurrentUser? {
      get {
        return (snapshot["currentUser"] as? Snapshot).flatMap { CurrentUser(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "currentUser")
      }
    }

    public struct CurrentUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("wallet", arguments: ["cryptocurrency": GraphQLVariable("cryptocurrency")], type: .object(Wallet.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(wallet: Wallet? = nil) {
        self.init(snapshot: ["__typename": "User", "wallet": wallet.flatMap { (value: Wallet) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var wallet: Wallet? {
        get {
          return (snapshot["wallet"] as? Snapshot).flatMap { Wallet(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "wallet")
        }
      }

      public struct Wallet: GraphQLSelectionSet {
        public static let possibleTypes = ["Wallet"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("confirmedBalance", type: .scalar(String.self)),
          GraphQLField("unconfirmedBalance", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .nonNull(.scalar(Int.self))),
          GraphQLField("cryptocurrency", type: .scalar(Cryptocurrency.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(confirmedBalance: String? = nil, unconfirmedBalance: String? = nil, updatedAt: Int, cryptocurrency: Cryptocurrency? = nil) {
          self.init(snapshot: ["__typename": "Wallet", "confirmedBalance": confirmedBalance, "unconfirmedBalance": unconfirmedBalance, "updatedAt": updatedAt, "cryptocurrency": cryptocurrency])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var confirmedBalance: String? {
          get {
            return snapshot["confirmedBalance"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "confirmedBalance")
          }
        }

        public var unconfirmedBalance: String? {
          get {
            return snapshot["unconfirmedBalance"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "unconfirmedBalance")
          }
        }

        public var updatedAt: Int {
          get {
            return snapshot["updatedAt"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var cryptocurrency: Cryptocurrency? {
          get {
            return snapshot["cryptocurrency"] as? Cryptocurrency
          }
          set {
            snapshot.updateValue(newValue, forKey: "cryptocurrency")
          }
        }
      }
    }
  }
}