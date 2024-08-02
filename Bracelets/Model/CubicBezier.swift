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
    
    func scaled(by num: Num) -> CubicBezier {
        .init(
            start: start.scaled(by: num),
            end: end.scaled(by: num),
            controlPoint1: controlPoint1.scaled(by: num),
            controlPoint2: controlPoint2.scaled(by: num)
        )
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
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return path
    }
}

extension CubicBezier {
    
    static let a = CubicBezier(
        start: .init(x: 0.024, y: 1 - 0.357),
        end: .init(x: 0.973, y: 1 - 0.63),
        controlPoint1: .init(x: 0.127, y: 1 - 0.824),
        controlPoint2: .init(x: 0.944, y: 1 - 0.05))
    
    static let b = CubicBezier(
        start: CGPoint(x: 0.05, y: 1 - 0.46),
        end: CGPoint(x: 0.96, y: 1 - 0.548),
        controlPoint1: CGPoint(x: 0.593, y: 1 - 0.533),
        controlPoint2: CGPoint(x: 0.775, y: 1 - 0.31))
    
    static let c = CubicBezier(
        start: CGPoint(x: 0.05, y: 1 - 0.5),
        end: CGPoint(x: 0.95, y: 1 - 0.5),
        controlPoint1: CGPoint(x: 0.05, y: 1 - 0.5),
        controlPoint2: CGPoint(x: 0.95, y: 1 - 0.5))
    
    static let d = CubicBezier(
        start: CGPoint(x: 0.057, y: 1 - 0.532),
        end: CGPoint(x: 0.95, y: 1 - 0.5),
        controlPoint1: CGPoint(x: 0.616, y: 1 - 0.516),
        controlPoint2: CGPoint(x: 0.838, y: 1 - 0.353))
    
    static let e = CubicBezier(
        start: CGPoint(x: 0.057, y: 1 - 0.51),
        end: CGPoint(x: 0.95, y: 1 - 0.5),
        controlPoint1: CGPoint(x: 0.264, y: 1 - 0.581),
        controlPoint2: CGPoint(x: 0.271, y: 1 - 0.466))
    
    static let f = CubicBezier(
        start: .init(x: 0.05, y: 1 - 0.51),
        end: .init(x: 0.95, y: 1 - 0.496),
        controlPoint1: .init(x: 0.26, y: 1 - 0.297),
        controlPoint2: .init(x: 0.433, y: 1 - 0.644))
    
    static let g = CubicBezier(
        start: .init(x: 0.05, y: 1 - 0.57),
        end: .init(x: 0.95, y: 1 - 0.496),
        controlPoint1: .init(x: 0.27, y: 1 - 0.32),
        controlPoint2: .init(x: 0.76, y: 1 - 0.6))

    static let h = CubicBezier(
        start: .init(x: 0.05, y: 1 - 0.476),
        end: .init(x: 0.946, y: 1 - 0.46),
        controlPoint1: .init(x: 0.376, y: 1 - 0.776),
        controlPoint2: .init(x: 0.786, y: 1 - 0.386))

    static let i = CubicBezier(
        start: .init(x: 0.05, y: 1 - 0.476),
        end: .init(x: 0.94, y: 1 - 0.51),
        controlPoint1: .init(x: 0.393, y: 1 - 0.36),
        controlPoint2: .init(x: 0.786, y: 1 - 0.4))

    static let j = CubicBezier(
        start: .init(x: 0.06, y: 1 - 0.514),
        end: .init(x: 0.94, y: 1 - 0.51),
        controlPoint1: .init(x: 0.764, y: 1 - 0.59),
        controlPoint2: .init(x: 0.348, y: 1 - 0.367))

    static let k = CubicBezier(
        start: .init(x: 0.06, y: 1 - 0.514),
        end: .init(x: 0.94, y: 1 - 0.51),
        controlPoint1: .init(x: 0.316, y: 1 - 0.703),
        controlPoint2: .init(x: 0.954, y: 1 - 0.376))
    
    static let l = CubicBezier(
        start: .init(x: 0.06, y: 1 - 0.514),
        end: .init(x: 0.96, y: 1 - 0.437),
        controlPoint1: .init(x: 0.4, y: 1 - 0.533),
        controlPoint2: .init(x: 0.71, y: 1 - 0.67))
    
    
    static let examples = [CubicBezier.a, .b, .c, .d, .e, .f, .g, .h, .i, .j, .k, .l]
    
    
    
}


