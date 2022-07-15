//
//  CalculatorTheme.swift
//  Calc
//
//  Created by Luis Santander on 5/29/22.
//

import Foundation


enum StatusBarStyle {
    case light
    case dark
}


struct CalculatorTheme {
    let backgroundColor: String
    let displayColor: String
    
    let extraFunctionColor: String
    let extraFunctionTitleColor: String
    
    let operationColor: String
    let operationTitleColor: String
    
    let pinpadColor: String
    let pinpadTitleColor: String
    
    let statusBarStyle: StatusBarStyle
    
    let fontSize: Float
}
