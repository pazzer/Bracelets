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
    
    case circle_fill = "circle.fill"
    
    case questionmark_circle_fill = "questionmark.circle.fill"
    case exclamationmark_circle_fill = "exclamationmark.circle.fill"
    case heart_circle_fill = "heart.circle.fill"
    case hand_thumbsup_circle = "hand.thumbsup.circle"
    case hammer_circle_fill = "hammer.circle.fill"
    case cloud_circle_fill = "cloud.circle.fill"
    case moon_circle_fill = "moon.circle.fill"
    case dog_circle_fill = "dog.circle.fill"
    case fish_circle_fill = "fish.circle.fill"
    case baseball_circle_fill = "baseball.circle.fill"
    case star_circle_fill = "star.circle.fill"
    case plus_circle_fill = "plus.circle.fill"
    case cat_circle_fill = "cat.circle.fill"
    case sterlingsign_circle_fill = "sterlingsign.circle.fill"
    case bed_double_circle_fill = "bed.double.circle.fill"
    
    case nine_circle_fill = "9.circle.fill"
    case eight_circle_fill = "8.circle.fill"
    case seven_circle_fill = "7.circle.fill"
    case six_circle_fill = "6.circle.fill"
    case five_circle_fill = "5.circle.fill"
    case four_circle_fill = "4.circle.fill"
    case three_circle_fill = "3.circle.fill"
    case two_circle_fill = "2.circle.fill"
    case one_circle_fill = "1.circle.fill"
    case zero_circle_fill = "0.circle.fill"
    
    static func random() -> SFSymbol {
        allCases.randomElement()!
    }
    
}

extension SFSymbol {
    
    static func symbols(for string: String) -> [SFSymbol] {
        string.map { character in
            symbol(for: character)
        }
    }
    
    var character: Character {
        switch self {
        case .a_circle_fill:
            return "a"
        case .b_circle_fill:
            return "b"
        case .c_circle_fill:
            return "c"
        case .d_circle_fill:
            return "d"
        case .e_circle_fill:
            return "e"
        case .f_circle_fill:
            return "f"
        case .g_circle_fill:
            return "g"
        case .h_circle_fill:
            return "h"
        case .i_circle_fill:
            return "i"
        case .j_circle_fill:
            return "j"
        case .k_circle_fill:
            return "k"
        case .l_circle_fill:
            return "l"
        case .m_circle_fill:
            return "m"
        case .n_circle_fill:
            return "n"
        case .o_circle_fill:
            return "o"
        case .p_circle_fill:
            return "o"
        case .q_circle_fill:
            return "q"
        case .r_circle_fill:
            return "r"
        case .s_circle_fill:
            return "s"
        case .t_circle_fill:
            return "t"
        case .u_circle_fill:
            return "u"
        case .v_circle_fill:
            return "v"
        case .w_circle_fill:
            return "w"
        case .x_circle_fill:
            return "x"
        case .y_circle_fill:
            return "y"
        case .z_circle_fill:
            return "z"
        case .circle_fill:
            return " "
        case .questionmark_circle_fill:
            return "?"
        case .exclamationmark_circle_fill:
            return "!"
        case .plus_circle_fill:
            return "+"
        case .heart_circle_fill:
            return "❤️"
        case .hand_thumbsup_circle:
            return "👍"
        case .hammer_circle_fill:
            return "🔨"
        case .cloud_circle_fill:
            return "☁️"
        case .moon_circle_fill:
            return "🌙"
        case .dog_circle_fill:
            return "🦮"
        case .fish_circle_fill:
            return "🐟"
        case .baseball_circle_fill:
            return "⚾️"
        case .star_circle_fill:
            return "⭐️"
        case .cat_circle_fill:
            return "🐈‍⬛"
        case .sterlingsign_circle_fill:
            return "£"
        case .bed_double_circle_fill:
            return "🛏️"
        case .nine_circle_fill:
            return "9"
        case .eight_circle_fill:
            return "8"
        case .seven_circle_fill:
            return "7"
        case .six_circle_fill:
            return "6"
        case .five_circle_fill:
            return "5"
        case .four_circle_fill:
            return "4"
        case .three_circle_fill:
            return "3"
        case .two_circle_fill:
            return "2"
        case .one_circle_fill:
            return "1"
        case .zero_circle_fill:
            return "0"
            
        }
    }
    
    static func symbol(for character: Character) -> SFSymbol {
        if character.isLetter || character.isNumber {
            return SFSymbol(rawValue: "\(character.lowercased()).circle.fill") ?? .questionmark_circle_fill
        } else {
            switch character {
            case "!":
                return .exclamationmark_circle_fill
            case "?":
                return .questionmark_circle_fill
            case " ":
                return .circle_fill
            case "+":
                return .plus_circle_fill
            case "☁️":
                return .cloud_circle_fill
            case "👍":
                return .hand_thumbsup_circle
            case "🌙":
                return .moon_circle_fill
            case "🦮":
                return .dog_circle_fill
            case "🔨":
                return .hammer_circle_fill
            case "🐟":
                return .fish_circle_fill
            case "⚾️":
                return .baseball_circle_fill
            case "❤️":
                return .heart_circle_fill
            case "⭐️":
                return .star_circle_fill
            case "🐈‍⬛":
                return .cat_circle_fill
            case "£":
                return .sterlingsign_circle_fill
            case "🛏️":
                return .bed_double_circle_fill
            default:
                return .questionmark_circle_fill
            }
        }
    }
    
    
}

//tortoise.circle.fill
//hare.circle.fill
//airplane.circle.fill
//binoculars.circle.fill
