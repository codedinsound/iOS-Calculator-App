import Foundation

extension CalcViewController {
    
    var darkTheme: CalculatorTheme {
        return CalculatorTheme(
            backgroundColor:                "#000000",
            displayColor:                   "#FFFFFF",
                               
            extraFunctionColor:             "#a6a6a6",
            extraFunctionTitleColor:        "#000000",
                               
            operationColor:                 "#ff9f0a",
            operationTitleColor:            "#FFFFFF",
                               
            pinpadColor:                    "#333333",
            pinpadTitleColor:               "#FFFFFF",
        
            fontSize: 40)
    }
}
