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
    
    // MARK: - Math Equation
    
    // NOTE: What set is we have allowed this behavior by adding a private setter so only this file
    //       can set a value to the math equation. The external files will be avble to reference the
    //       the external values. 
    private(set) var mathEquation = MathEquation(lhs: .zero)
    
    
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
    
    mutating func percentagePressed() {
        switch operandSide {
        case .leftHandSide:
            mathEquation.applyPercentageToLeftHandSide()
            lcdDisplayText = mathEquation.lhs.formatted()
        case .rightHandSide:
            mathEquation.applyPercentageToRightHandSide()
            lcdDisplayText = mathEquation.rhs?.formatted() ?? "Error" // I Think we need to use the DRY principle.
        }
    }
    
    mutating func addPressed() {
        // mathEquation.operation = MathEquation.OperationType.add // Explicitly stating but you can
        // impliclity reduce code since the swift controller is smart enough to know what you are saying.
        mathEquation.operation = .add
        operandSide = .rightHandSide
    }
    
    mutating func minusPressed() {
        mathEquation.operation = .subtract
        operandSide = .rightHandSide
    }
    
    mutating func multiplyPressed() {
        mathEquation.operation = .multiply
        operandSide = .rightHandSide
    }
    
    mutating func dividePressed() {
        mathEquation.operation = .divide
        operandSide = .rightHandSide
    }
    
    mutating func execute() {
        mathEquation.execute()
        lcdDisplayText = mathEquation.result?.formatted() ?? "Error"
    }
    
    mutating func decimalPressed() {
        
    }
    
    mutating func numberPressed(_ number: Int) {
        let decimalValue = Decimal(number)
        lcdDisplayText = decimalValue.formatted()
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.lhs = decimalValue
        case .rightHandSide:
            mathEquation.rhs = decimalValue
        }
    }
    
    // MARK: - Initialized
    
    init() {
        lcdDisplayText = mathEquation.lhs.formatted()
    }
    
    
}
