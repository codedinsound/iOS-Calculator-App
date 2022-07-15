import Foundation

extension CalcViewController {
    
    var washedOutTheme: CalculatorTheme {
        return CalculatorTheme(
            backgroundColor:                "#ECF5FF",
            displayColor:                   "#0D2A4B",
                               
            extraFunctionColor:             "#A3CFF9",
            extraFunctionTitleColor:        "#5487BA",
                               
            operationColor:                 "#A3CFF9",
            operationTitleColor:            "#5487BA",
                               
            pinpadColor:                    "#1D1D1D",
            pinpadTitleColor:               "#FFFFFF",
        
            statusBarStyle: .dark,
            
            fontSize: 40)
    }
}
