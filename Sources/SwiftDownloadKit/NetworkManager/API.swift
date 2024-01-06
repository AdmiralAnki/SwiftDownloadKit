//
//  File.swift
//  
//
//  Created by Ankith K on 06/01/24.
//

import Foundation

public protocol API{
    var httpMethod:HTTPMethod { get }
    var httpScheme:HTTPScheme {get}
    var path:String {get}
    var host:String {get}
    var httpBody:Data? {get}
    var headerParam:[String:String]? {get}
    var queryParams:[URLQueryItem]?  {get}
}

public enum HTTPMethod:String{
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}

public enum HTTPScheme:String{
    case http = "http"
    case https = "https"
}
