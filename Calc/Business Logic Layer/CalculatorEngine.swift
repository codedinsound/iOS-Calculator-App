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

// NOTE: The calculator engine in terms of hierarchy it sits right at the top, taking ownership of all the
//       behavior beneath it. It is the manager of the calculator.

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
    
    mutating func negatePressed() {
        inputController.negatePressed()
    }
    
    mutating func percentagePressed() {
        inputController.percentagePressed()
    }
    
    // MARK: - Operations
    
    mutating func addPressed() {
        inputController.addPressed()
    }
    
    mutating func minusPressed() {
        inputController.minusPressed()
    }
    
    mutating func multiplyPressed() {
        inputController.multiplyPressed()
    }
    
    mutating func dividePressed() {
        inputController.dividePressed()
    }
    
    mutating func equalsPressed() {
        inputController.execute() 
        historyLog.append(inputController.mathEquation)
        printEquationToDebugConsole()
    }
    
    // MARK: - Number Input
    
    mutating func decimalPressed() {
        inputController.decimalPressed()
    }
    
    mutating func numberPressed(_ number: Int) {
        inputController.numberPressed(number)
    }
    
    // MARK: Debug Console
    
    private func printEquationToDebugConsole() {
        print("Equation: " + inputController.mathEquation.generatePrintOut())
    }
    
    // MARK: - History Log
    private mutating func clearHistory() {
        historyLog = []
    }
}


