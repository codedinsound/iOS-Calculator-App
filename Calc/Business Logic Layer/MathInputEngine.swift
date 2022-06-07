//
//  MathInputEngine.swift
//  Calc
//
//  Created by Luis Santander on 6/4/22.
//

// You can call engine, controllers, managers same thing but they manage data

import Foundation


struct MathInputEngine {
    
    // MARK: Operand Editing Side
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }
    
    private var operandSide = OperandSide.leftHandSide
    private var mathEquation = MathEquation(lhs: .zero)
    
    // MARK: - LCD Display
    var lcdDisplayText = ""
    
    // Mark: - Extra Functions
    mutating func negatePressed() {
        switch operandSide {
        case .leftHandSide:
            mathEquation.negateLeftHandSide()
            lcdDisplayText = mathEquation.lhs.formatted()
        case .rightHandSide:
            mathEquation.negateRightHandSide()
            lcdDisplayText = mathEquation.rhs?.formatted() ?? "Error"
        }
    }
    
    
    // MARK: - Initialized
    
    init() {
        lcdDisplayText = mathEquation.lhs.formatted()
    }
    
    
}
