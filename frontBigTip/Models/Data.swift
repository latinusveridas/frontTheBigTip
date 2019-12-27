//
//  DataProcessing.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import UIKit
import SwiftUI

let previewData: [Preview] = {
    guard let data = loadJSONfile(url: "previewData.json") else { print("No data loaded") }
    guard let previewList = ParsingJSONtoListPreview(data: data) else { print("No preview list created") }
    return previewList
}

func loadJSONfile(url: url) -> Data {
/* Load File to Data */

    let url = Bundle.main.url(forResource: url, withExtension: "json")!
    guard let data = try! Data(contentsOf: url, using: .utf8) else { fatalError("☠️") }
    return data
}

func ParsingJSONtoListPreview(data: Data) -> [Preview] {
/* Serialize JSON to List of Preview objects */

    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let previewsList = try decoder.decode([Preview].self, from: data)
        print(previewsList)
        return previewsList
    } catch {
        print(error)
    }
    
}