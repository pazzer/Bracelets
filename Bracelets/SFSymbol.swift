//
//  SFSymbol+StringBuilder.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import Foundation

enum SFSymbol: String, CaseIterable {
    
    case a_circle_fill = "a.circle.fill"
    case b_circle_fill = "b.circle.fill"
    case c_circle_fill = "c.circle.fill"
    case d_circle_fill = "d.circle.fill"
    case e_circle_fill = "e.circle.fill"
    case f_circle_fill = "f.circle.fill"
    case g_circle_fill = "g.circle.fill"
    case h_circle_fill = "h.circle.fill"
    case i_circle_fill = "i.circle.fill"
    case j_circle_fill = "j.circle.fill"
    case k_circle_fill = "k.circle.fill"
    case l_circle_fill = "l.circle.fill"
    case m_circle_fill = "m.circle.fill"
    case n_circle_fill = "n.circle.fill"
    case o_circle_fill = "o.circle.fill"
    case p_circle_fill = "p.circle.fill"
    case q_circle_fill = "q.circle.fill"
    case r_circle_fill = "r.circle.fill"
    case s_circle_fill = "s.circle.fill"
    case t_circle_fill = "t.circle.fill"
    case u_circle_fill = "u.circle.fill"
    case v_circle_fill = "v.circle.fill"
    case w_circle_fill = "w.circle.fill"
    case x_circle_fill = "x.circle.fill"
    case y_circle_fill = "y.circle.fill"
    case z_circle_fill = "z.circle.fill"
    
    case questionmark_circle_fill = "questionmark.circle.fill"
    case exclamationmark_circle_fill = "exclamationmark.circle.fill"
    
    case circle_fill = "circle.fill"
    case heart_circle_fill = "heart.circle.fill"
    
}

extension SFSymbol {
    
    static func symbols(for string: String) -> [SFSymbol] {
        string.map { character in
            symbol(for: character)
        }
    }
    
    static func symbol(for character: Character) -> SFSymbol {
        if character.isLetter {
            return SFSymbol(rawValue: "\(character.lowercased()).circle.fill") ?? .questionmark_circle_fill
        } else {
            switch character {
            case "!":
                return .exclamationmark_circle_fill
            case "?":
                return .questionmark_circle_fill
            case " ":
                return .circle_fill
            default:
                return .questionmark_circle_fill
            }
        }
    }
    
    
}
