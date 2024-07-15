//
//  CubicBezier.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import Foundation
import class UIKit.UIBezierPath

/// The code here is from an answer to this question https://stackoverflow.com/questions/4089443/find-the-tangent-of-a-point-on-a-cubic-bezier-curve.
struct CubicBezier {

    private typealias Me = CubicBezier
    typealias Vector = CGVector
    typealias Point = CGPoint
    typealias Num = CGFloat
    typealias Coeficients = (C: Num, S: Num, M: Num, L: Num)

    let xCoeficients: Coeficients
    let yCoeficients: Coeficients
    
    let start: Point
    let end: Point
    let controlPoint1: Point
    let controlPoint2: Point

    static func coeficientsOfCurve(from c0: Num, through c1: Num, andThrough c2: Num, to c3: Num) -> Coeficients
    {
        let _3c0 = c0 + c0 + c0
        let _3c1 = c1 + c1 + c1
        let _3c2 = c2 + c2 + c2
        let _6c1 = _3c1 + _3c1

        let C = c3 - _3c2 + _3c1 - c0
        let S = _3c2 - _6c1 + _3c0
        let M = _3c1 - _3c0
        let L = c0

        return (C, S, M, L)
    }

    static func xOrYofCurveWith(coeficients coefs: Coeficients, at t: Num) -> Num
    {
        let (C, S, M, L) = coefs
        return ((C * t + S) * t + M) * t + L
    }

    static func xOrYofTangentToCurveWith(coeficients coefs: Coeficients, at t: Num) -> Num
    {
        let (C, S, M, _) = coefs
        return ((C + C + C) * t + S + S) * t + M
    }

    init(start: Point, end: Point, controlPoint1: Point, controlPoint2: Point)
    {
        self.start = start
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
        self.end = end
        
        xCoeficients = Me.coeficientsOfCurve(from: start.x, through: controlPoint1.x, andThrough: controlPoint2.x, to: end.x)
        yCoeficients = Me.coeficientsOfCurve(from: start.y, through: controlPoint1.y, andThrough: controlPoint2.y, to: end.y)
    }
    

    func x(at t: Num) -> Num {
        return Me.xOrYofCurveWith(coeficients: xCoeficients, at: t)
    }

    func y(at t: Num) -> Num {
        return Me.xOrYofCurveWith(coeficients: yCoeficients, at: t)
    }

    func dx(at t: Num) -> Num {
        return Me.xOrYofTangentToCurveWith(coeficients: xCoeficients, at: t)
    }

    func dy(at t: Num) -> Num {
        return Me.xOrYofTangentToCurveWith(coeficients: yCoeficients, at: t)
    }

    func point(at t: Num) -> Point {
        return .init(x: x(at: t), y: y(at: t))
    }

    func tangent(at t: Num) -> Vector {
        return .init(dx: dx(at: t), dy: dy(at: t))
    }
    
    
}


/// Conenience extension (my own code).
extension CubicBezier {
    
    /// Creates an instance of `CubicBezier` from four points: [P0, P1, P2, P3].
    init(from points: [CGPoint]) {
        precondition(points.count == 4)
        self.init(start: points[0], end: points[3], controlPoint1: points[1], controlPoint2: points[2])
    }
    
    /// Returns the angle the tangent at t makes with the x-axis.
    /// This value is most commonly used for rotating letters positioned along a bezier path.
    func xAngle(at t: Num, in unit: UnitAngle = .radians) -> Measurement<UnitAngle> {
        let tangent = tangent(at: t)
        let dx = tangent.dx
        let dy = tangent.dy
        let rads = Measurement<UnitAngle>(value: atan(dy / dx), unit: .radians)
        return rads.converted(to: unit)
    }
    
    /// Returns the arc length from the start of the curve up to the coordinate associated with the specified t.
    /// The default value of `t` is 1.
    func arcLength(to t: Double = 1, precision n: Int = 32) -> Double {
        precondition((2...64).contains(n))
        let weights = lgqWeights[n]!
        let abscissa = lgqAbscissae[n]!
        let Z = t / 2
        
        let function: (Double) -> Double = { t in
            let sum = pow(dx(at: t), 2) + pow(dy(at: t), 2)
            return pow(sum, 0.5)
        }
        
        // `wa` -> 'weights|abscissae'
        return zip(weights, abscissa).reduce(0) { (partialResult, wa) in
            partialResult + function(Z * wa.1 + Z) * wa.0 * Z
        }
    }
    
    func bezierPath() -> UIBezierPath {
        var path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return path
    }
}

//extension CubicBezier {
//    
//    static let ex1 = CubicBezier(from: [])
//    
//    
//}
//
//enum BezierCurve {
//    
//    case
//
//}
//
//
