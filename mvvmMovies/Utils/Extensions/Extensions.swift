//
//  Extensions.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 03/08/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation

extension Decodable {
    func dateFormatter(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDate = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: myDate)
    }
}
