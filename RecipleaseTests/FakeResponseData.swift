//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by megared on 04/11/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

class FakeResponseData {
//MARK: - Fake data common to all
/// Fake response OK
static let responseOK = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
/// Fake response KO
static let responseKO = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
}
