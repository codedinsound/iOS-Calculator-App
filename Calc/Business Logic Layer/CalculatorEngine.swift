//
//  CalculatorEngine.swift
//  Calc
//
//  Created by iOSBFree on 25/01/2022.
//
//  iOSBFree Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💜 iOSBFree
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's the core of the calculator. The brain. It generates all of our behaviour.
//   Architecural Layer: Business Logic Layer

//   Exposed behaviour the API of the application. 
//
//   So let's just remember the responsiblity of the    calculator engine is going to be control the API.
// *******************************************************************************************
import Foundation

struct CalculatorEngine {
    
    // MARK: - Math Input Controller Engine
    private var inputController = MathInputEngine()
    
    // MARK: - Equation History
    private var historyLog: [MathEquation] = []
    
    // MARK: LCD Display
    var lcdDisplayText: String {
        return inputController.lcdDisplayText
    }

    // MARK: Extra Functions
    mutating func clearPressed() {
        inputController = MathInputEngine()
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
    
    // MARK: - Operations
    
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
    
    mutating func equalsPressed() {
        mathEquation.execute()
        historyLog.append(mathEquation)
        printEquationToDebugConsole()
        lcdDisplayText = mathEquation.result?.formatted() ?? "Error"
    }
    
    // MARK: - Number Input
    
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
    
    // MARK: Debug Console
    
    private func printEquationToDebugConsole() {
        print("Equation: " + mathEquation.generatePrintOut())
    }
    
    // MARK: - History Log
    private mutating func clearHistory() {
        historyLog = []
    }
}
