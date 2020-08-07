//
//  Bundle+Extension.swift
//  mvvmMovies
//
//  Created by Wesley Brito on 21/07/20.
//  Copyright © 2020 wb. All rights reserved.
//

import Foundation

extension Bundle {
    var apiKey: String {
        if let path = Bundle.main.path(forResource: "apikey", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            return dict["apikey"] ?? ""
        }
        return ""
    }

    static func loadJSONFromBundle(bundle: Bundle = Bundle.main, resourceName: String) -> Data {
        guard let url = bundle.url(forResource: resourceName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
}
