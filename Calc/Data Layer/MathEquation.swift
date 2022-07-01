//
//  MathEquation.swift
//  Calc
//
//  Created by Luis Santander on 5/30/22.
//

import Foundation

// Struct Value types are inmutable they cannot change types.
struct MathEquation {
    
    enum OperationType {
        case add
        case subtract
        case multiply
        case divide
    }
    
    var lhs: Decimal
    var rhs: Decimal?
    var operation: OperationType?
    var result: Decimal? // ? if in fact exists ? conditional.
    
    // MARK: - Execution
    var executed: Bool {
        return result != nil
    }
    
    // mutating keyword is this function changes the struct. it mutates things.
    mutating func execute() {
       
        
        // don't let the code continue unless
        guard
            let rhs = self.rhs,
            let operation = self.operation else {
                return
        }
        
        switch operation {
            case .add:
                result = lhs + rhs
            case .subtract:
                result = lhs - rhs
            case .multiply:
                result = lhs * rhs
            case .divide:
                result = lhs / rhs
        }
    }
    
    // MARK: - Negate Functions
    mutating func negateLeftHandSide() {
        lhs.negate()
    }
    
    mutating func negateRightHandSide() {
        rhs?.negate()
    }
    
    // MARK: - Percentage
    mutating func applyPercentageToLeftHandSide() {
        lhs = calculatePercentageValue(lhs)
    }
  
    mutating func applyPercentageToRightHandSide() {
        guard let decimal = rhs else { return }
        rhs = calculatePercentageValue(decimal)
    }
    
    private func calculatePercentageValue(_ decimal: Decimal) -> Decimal {
        return decimal / 100
    }
    
    // MARK: - String Representation
    func generatePrintOut() -> String {
        // A + B = C
        let operationString = generateStringRepresentationOfOperation()
        return lhs.formatted() + " " + operationString + " " + (rhs?.formatted() ?? "") + " = " + (result?.formatted() ?? "")
    }
    
    private func generateStringRepresentationOfOperation() -> String {
        switch operation {
            case .add: return "+"
            case .subtract: return "-"
            case .multiply: return "x"
            case .divide: return "/"
            case .none: return ""
        }
    }
}
