//
//  Double.swift
//  WATERCO
//
//  Created by Abdulqadar on 19/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}