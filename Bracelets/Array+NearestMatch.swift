//
//  Search.swift
//  Bracelets
//
//  Created by Paul Patterson on 15/07/2024.
//

import Foundation

enum MatchRule {
    case firstAbove
    case firstBelow
    case closest
}

extension Array where Element: Numeric & Comparable {
    
    /// Returns the index of the array Element closest to `target`. The definition of '
    /// closest' can is specified via ` matchRule`.
    ///
    /// - Warning: self must be sorted in ascending order before calling this method..
    func indexOfNearestMatch(_ target: Element, matchRule: MatchRule) -> Int? {
        guard (self[0]...self[self.count - 1]).contains(target) else { return nil }
        var low = 0
        var high = self.count - 1
        while true {
            let (q, r) = (high - low).quotientAndRemainder(dividingBy: 2)
            
            if r > 0 {
                // Check value is not between low and high
                if self[low + q] < target {
                    if self[low + q + 1] > target {
                        switch matchRule {
                        case .closest:
                            let lower = self[low + q]
                            let upper = self[low + q + 1]
                            if (target - lower) > (upper - target) {
                                return low + q + 1
                            } else {
                                return low + q
                            }
                        case .firstAbove:
                            return low + q + 1
                        case .firstBelow:
                            return low + q
                        }
                    } else {
                        low = low + q + 1
                    }
                } else {
                    high = low + q
                }
            } else if self[low + q] == target {
                return low + q
            } else if self[low + q] < target {
                low = low + q
            } else {
                high = low + q
            }
        }
    }

}


