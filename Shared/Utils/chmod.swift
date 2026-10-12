import Foundation

/// The three bits in one Unix permission digit.
public struct Permission: OptionSet, Sendable, Hashable {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }

    public static let read = Permission(rawValue: 4)
    public static let write = Permission(rawValue: 2)
    public static let execute = Permission(rawValue: 1)

    public var symbolic: String {
        String([
            contains(.read) ? "r" : "-",
            contains(.write) ? "w" : "-",
            contains(.execute) ? "x" : "-"
        ])
    }

    public var calculation: String {
        let values = [(Self.read, "4"), (.write, "2"), (.execute, "1")]
            .filter { contains($0.0) }.map { $0.1 }
        return "\(values.isEmpty ? "0" : values.joined(separator: " + ")) = \(rawValue)"
    }
}

public enum Audience: String, CaseIterable, Identifiable, Sendable {
    case owner, group, others
    public var id: Self { self }
    public var title: String { rawValue.capitalized }
    public var explanation: String {
        switch self {
        case .owner: "The account that owns the file."
        case .group: "Accounts in the file’s owning group."
        case .others: "Everyone else."
        }
    }
}

/// Basic permissions only: exactly three octal digits or nine rwx characters.
public struct PermissionMode: Equatable, Sendable {
    public var owner: Permission
    public var group: Permission
    public var others: Permission

    public init(owner: Permission, group: Permission, others: Permission) {
        self.owner = owner
        self.group = group
        self.others = others
    }

    public init?(octal: String) {
        guard octal.count == 3, octal.allSatisfy({ ("0"..."7").contains(String($0)) }) else { return nil }
        let digits = octal.compactMap(\.wholeNumberValue)
        self.init(owner: Permission(rawValue: digits[0]),
                  group: Permission(rawValue: digits[1]),
                  others: Permission(rawValue: digits[2]))
    }

    public init?(symbolic: String) {
        guard symbolic.count == 9 else { return nil }
        let chars = Array(symbolic)
        var digits = [Int]()
        for offset in stride(from: 0, to: 9, by: 3) {
            guard let digit = rwxToInt(chars: chars[offset..<offset + 3].map { Optional($0) }) else { return nil }
            digits.append(digit)
        }
        self.init(owner: Permission(rawValue: digits[0]),
                  group: Permission(rawValue: digits[1]),
                  others: Permission(rawValue: digits[2]))
    }

    public static let standard = PermissionMode(owner: [.read, .write, .execute],
                                                group: [.read, .execute], others: [.read, .execute])
    public var octal: String { "\(owner.rawValue)\(group.rawValue)\(others.rawValue)" }
    public var symbolic: String { owner.symbolic + group.symbolic + others.symbolic }

    public subscript(audience: Audience) -> Permission {
        get {
            switch audience {
            case .owner: owner
            case .group: group
            case .others: others
            }
        }
        set {
            switch audience {
            case .owner: owner = newValue
            case .group: group = newValue
            case .others: others = newValue
            }
        }
    }
}

// Keep the original conversion API, with strict validation and consistent rwx order.
public func totalIntToRwx(int: Int) -> [[Character?]]? {
    guard (0...777).contains(int),
          let mode = PermissionMode(octal: String(format: "%03d", int)) else { return nil }
    return Audience.allCases.map { intToRwx(int: mode[$0].rawValue)! }
}

public func totalRwxToInt(chars: [[Character?]]) -> Int? {
    guard chars.count == 3 else { return nil }
    let digits = chars.compactMap { rwxToInt(chars: $0) }
    guard digits.count == 3 else { return nil }
    return digits[0] * 100 + digits[1] * 10 + digits[2]
}

public func rwxToInt(chars: [Character?]) -> Int? {
    guard chars.count == 3 else { return nil }
    let expected: [Character] = ["r", "w", "x"]
    var digit = 0
    for index in chars.indices {
        guard let char = chars[index], char != "-" else { continue }
        guard char.lowercased() == String(expected[index]) else { return nil }
        digit |= [4, 2, 1][index]
    }
    return digit
}

public func intToRwx(int: Int) -> [Character?]? {
    guard (0...7).contains(int) else { return nil }
    return Permission(rawValue: int).symbolic.map { $0 == "-" ? nil : $0 }
}
