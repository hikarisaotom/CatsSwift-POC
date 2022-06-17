//
//  API.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/16/22.
//

import Foundation
import Alamofire
struct API {
    private static var  key = "c1f2e222-32ab-4581-89e7-953017a7e047";
    static var headers: HTTPHeaders = ["x-api-key": key]
}
struct APIParameters: Encodable {
    let category_ids: Int
}

