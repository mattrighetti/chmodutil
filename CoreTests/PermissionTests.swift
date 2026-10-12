import Testing
@testable import ChmodCore

@Test func allBasicModesRoundTrip() throws {
    for owner in 0...7 {
        for group in 0...7 {
            for others in 0...7 {
                let octal = "\(owner)\(group)\(others)"
                let mode = try #require(PermissionMode(octal: octal))
                #expect(mode.octal == octal)
                #expect(PermissionMode(symbolic: mode.symbolic) == mode)
                let value = owner * 100 + group * 10 + others
                let chars = try #require(totalIntToRwx(int: value))
                #expect(totalRwxToInt(chars: chars) == value)
                #expect(chars.map { String($0.map { $0 ?? "-" }) }.joined() == mode.symbolic)
            }
        }
    }
}

@Test func invalidInputIsRejected() {
    for value in ["", "75", "0755", "888", "758", "-12", "abc", "７５５", " 755"] {
        #expect(PermissionMode(octal: value) == nil)
    }
    for value in ["", "rwx", "xrwr-xr-x", "rwxr-xr-z", "rwsr-xr-x", "drwxr-xr-x"] {
        #expect(PermissionMode(symbolic: value) == nil)
    }
    for value in [-1, 8, 78, 778, 999] { #expect(totalIntToRwx(int: value) == nil) }
    #expect(rwxToInt(chars: ["x", "w", "r"]) == nil)
    #expect(totalRwxToInt(chars: []) == nil)
    #expect(intToRwx(int: 8) == nil)
}

@Test func knownPatternsAndLeadingZeros() throws {
    #expect(PermissionMode.standard.symbolic == "rwxr-xr-x")
    #expect(PermissionMode.standard.octal == "755")
    #expect(PermissionMode(octal: "064")?.symbolic == "---rw-r--")
    #expect(rwxToInt(chars: ["R", "W", "-"]) == 6)
    #expect(intToRwx(int: 4) == ["r", nil, nil])
    #expect(intToRwx(int: 1) == [nil, nil, "x"])
    #expect(Permission(rawValue: 0).calculation == "0 = 0")
    #expect(Permission(rawValue: 7).calculation == "4 + 2 + 1 = 7")
    var mode = try #require(PermissionMode(octal: "640"))
    mode[.owner].insert(.execute)
    #expect(mode.octal == "740")
    mode[.group].remove(.read)
    #expect(mode.octal == "700")
}
