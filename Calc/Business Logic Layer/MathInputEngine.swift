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
    private let groupingSymbol = Locale.current.groupingSeparator ?? ","
    private let decimalSymbol = Locale.current.decimalSeparator ?? "."
    private let minusSymbol = "-"
    
    // MARK: - Math Equation
    
    // NOTE: What set is we have allowed this behavior by adding a private setter so only this file
    //       can set a value to the math equation. The external files will be avble to reference the
    //       the external values. 
    private(set) var mathEquation = MathEquation(lhs: .zero)
    private var isEnteringDecimal = false
    
    // MARK: - LCD Display
    var lcdDisplayText = ""
    
    // MARK: - Extra Functions
    mutating func negatePressed() {
        guard isCompleted == false else { return }
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.negateLeftHandSide()
            displayNegateSymbolOnDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.negateRightHandSide()
            displayNegateSymbolOnDisplay(mathEquation.rhs)
        }
    }
    
    // With Negating Zero
    private mutating func displayNegateSymbolOnDisplay(_ decimal: Decimal?) {
        guard let decimal = decimal else { return }

        let isNegativeValue = decimal < 0 ? true : false
        if isNegativeValue {
            lcdDisplayText.addPrefixIfNeeded(minusSymbol)
        } else {
            lcdDisplayText.removePrefixIfNeeded(minusSymbol)
        }
    }
    
    mutating func percentagePressed() {
        guard isCompleted == false else { return }
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.applyPercentageToLeftHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.applyPercentageToRightHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.rhs) // I Think we need to use the DRY principle.
        }
    }
    
    // MARK: - Operations
    mutating func addPressed() {
        guard isCompleted == false else { return }
        // mathEquation.operation = MathEquation.OperationType.add // Explicitly stating but you can
        // impliclity reduce code since the swift controller is smart enough to know what you are saying.
        mathEquation.operation = .add
        startEditingRightHandSide()
    }
    
    mutating func minusPressed() {
        guard isCompleted == false else { return }
        
        mathEquation.operation = .subtract
        startEditingRightHandSide()
    }
    
    mutating func multiplyPressed() {
        guard isCompleted == false else { return }
        
        mathEquation.operation = .multiply
        startEditingRightHandSide()
    }
    
    mutating func dividePressed() {
        guard isCompleted == false else { return }
        
        mathEquation.operation = .divide
        startEditingRightHandSide()
    }
    
    mutating func execute() {
        // We Don't want this executed if code has been executed already.
        guard isCompleted == false else { return }
        
        mathEquation.execute()
        lcdDisplayText = formatLCDDisplay(mathEquation.result)
    }
    
    // MARK: - Editing Right Hand Side
    private mutating func startEditingRightHandSide() {
        operandSide = .rightHandSide
        isEnteringDecimal = false
    }
    
    mutating func decimalPressed() {
        isEnteringDecimal = true
        lcdDisplayText = appendDecimalPointIfNeeded(lcdDisplayText)
    }
    
    private func appendDecimalPointIfNeeded(_ string: String) -> String {
        if string.contains(decimalSymbol) {
            return string
        }
        return string.appending(decimalSymbol)
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
        
        guard isEnteringDecimal == false else {
            return appendNewDecimalNumber(number)
        }
        
        // Appends Whole Numbers
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
    
    private func appendNewDecimalNumber(_ number: Int) -> (newNumber: Decimal, newLcDisplayText: String) {
        let stringInput = String(number)
        let newLCDDisplayText = lcdDisplayText.appending(stringInput)
        
        // Convert a Number from a String
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        guard let convertedNumber = formatter.number(from: newLCDDisplayText) else { return (.nan, "Error") }
        
        let newNumber: Decimal = convertedNumber.decimalValue
        return (newNumber, newLCDDisplayText)
    }
    
    // MARK: LCD Display Formatting
    private func formatLCDDisplay(_ decimal: Decimal?) -> String {
        guard let decimal = decimal else { return "Error" }
        return decimal.formatted()
    }
    
    // MARK: - Computed Properties
    var isCompleted: Bool {
        return mathEquation.executed
    }
    
    // MARK: - Initialized
    
    init() {
        lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
    }
    
}
