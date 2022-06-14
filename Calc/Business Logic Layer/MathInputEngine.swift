//  MathInputEngine.swift
//  Calc
//
//  Created by Luis Santander on 6/4/22.

// You can call engine, controllers, managers same thing but they manage data

import Foundation

struct MathInputEngine {
    
    // MARK: Operand Editing Side
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }
    
    private var operandSide = OperandSide.leftHandSide
    
    // MARK: - Constants
    let groupingSymbol = Locale.current.groupingSeparator ?? ","
    
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
            lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.negateRightHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.rhs)
            
            
        }
    }
    
    mutating func percentagePressed() {
        switch operandSide {
        case .leftHandSide:
            mathEquation.applyPercentageToLeftHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.applyPercentageToRightHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.rhs) // I Think we need to use the DRY principle.
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
        lcdDisplayText = formatLCDDisplay(mathEquation.result)
    }
    
    mutating func decimalPressed() {
        
    }
    
    // NOTE: A Tuple is simply two values
    
    mutating func numberPressed(_ number: Int) {
        guard number >= -9, number <= 9 else { return }
        
        switch operandSide {
        case .leftHandSide:
            let tuple = appendNewNumber(number, toPreviousInput: mathEquation.lhs)
            mathEquation.lhs = tuple.newNumber
            lcdDisplayText = tuple.newLcDisplayText
        case .rightHandSide:
            let tuple = appendNewNumber(number, toPreviousInput: mathEquation.rhs ?? .zero)
            mathEquation.rhs = tuple.newNumber
            lcdDisplayText = tuple.newLcDisplayText
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousInput previousInput: Decimal) -> (newNumber: Decimal, newLcDisplayText: String) {
        let stringInput = String(number)
        var newStringRepresentation = previousInput.isZero ? "" : lcdDisplayText
        newStringRepresentation.append(stringInput)
        
        newStringRepresentation = newStringRepresentation.replacingOccurrences(of: groupingSymbol, with: "")
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        
        // Converted number cannot be constructed from this.
        guard let convertedNumber = formatter.number(from: newStringRepresentation) else { return (.nan, "Error") }
        
        let newNumber: Decimal = convertedNumber.decimalValue
        
        let newLCDDisplayText = formatLCDDisplay(newNumber)
        
        return (newNumber, newLCDDisplayText)
    }
    
    // MARK: LCD Display Formatting
    private func formatLCDDisplay(_ decimal: Decimal?) -> String {
        guard let decimal = decimal else { return "Error" }
        return decimal.formatted()
    }
    
    // MARK: - Initialized
    
    init() {
        lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
    }
    
    
}
