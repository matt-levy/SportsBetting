//
//  Functions.swift
//  MLB_Betting
//
//  Created by Matthew Levy on 7/19/23.
//

import Foundation

func decimalToAmericanOdds(_ decimalOdds: Double) -> String {
    if decimalOdds < 2.0 {
        let americanOdds = round(((-100) / (decimalOdds - 1)))
        return "\(Int(americanOdds))"
    } else {
        let americanOdds = round((decimalOdds - 1) * 100)
        return "+\(Int(americanOdds))"
    }
}
