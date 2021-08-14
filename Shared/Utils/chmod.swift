//
//  chmod.swift
//  chmodutil
//
//  Created by Mattia Righetti on 14/08/21.
//

import Foundation

public func totalIntToRwx(int: Int) -> [[Character?]]? {
    guard int <= 777 && int >= 0 else { return nil }
    let string: String = String(int)
    var chars = [[Character?]]()
    
    var counter = 0
    string.forEach { char in
        guard let val = intToRwx(int: Int(String(char))!) else {
            chars[counter] = [nil, nil, nil]
            return
        }
        chars[counter] = val
        counter += 1
    }
    
    return chars
}

public func totalRwxToInt(chars: [[Character?]]) -> Int? {
    guard
        chars.count == 3,
        let user = rwxToInt(chars: chars[0]),
        let group = rwxToInt(chars: chars[1]),
        let other = rwxToInt(chars: chars[2])
    else {
        return nil
    }
    return (user * 100) + (group * 10) + other
}

public func rwxToInt(chars: [Character?]) -> Int? {
    guard chars.count == 3 else { return nil }
    var r: Int = 0
    var w: Int = 0
    var x: Int = 0
    if chars[0] != nil && chars[0]?.lowercased() == "r" { r = 1 << 2 }
    if chars[1] != nil && chars[1]?.lowercased() == "w" { w = 1 << 1 }
    if chars[2] != nil && chars[2]?.lowercased() == "x" { x = 1 }
    return r | w | x
}

public func intToRwx(int: Int) -> [Character?]? {
    guard int <= 7 && int >= 0 else { return nil }
    var rwx = [Character?]()
    int & 1 == 1 ? rwx.append("x") : rwx.append(nil)
    int & 2 == 2 ? rwx.append("w") : rwx.append(nil)
    int & 4 == 4 ? rwx.append("r") : rwx.append(nil)
    return rwx
}
