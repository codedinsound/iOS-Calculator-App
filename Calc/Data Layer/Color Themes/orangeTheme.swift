import Foundation

extension CalcViewController {
    
    var orangeTheme: CalculatorTheme {
        return CalculatorTheme(
            backgroundColor:                "#DC6969",
            displayColor:                   "#FFFFFF",
                               
            extraFunctionColor:             "#D05353",
            extraFunctionTitleColor:        "#FFFFFF",
                               
            operationColor:                 "#CC4D4D",
            operationTitleColor:            "#FFFFFF",
                               
            pinpadColor:                    "#C94848",
            pinpadTitleColor:               "#FFFFFF",
            
            statusBarStyle: .light,
            
            fontSize: 40)
    }
}
