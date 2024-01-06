//
//  File.swift
//  
//
//  Created by Ankith K on 06/01/24.
//

import Foundation
@testable import SwiftDownloadKit

enum MockAPIEndpoints:API{
    
    
    case mockValidAPIEndpoint
    
    case mockInvalidAPIEndpoint
    
    case mockBytedownloader(Int)
    
    /*
     curl -X GET "https://httpbin.org/range/500" -H "accept: application/octet-stream"
     */
    
    var httpMethod: SwiftDownloadKit.HTTPMethod{
        switch self{
        case .mockInvalidAPIEndpoint,.mockValidAPIEndpoint,.mockBytedownloader:
            return .get
        }
    }
    
    var httpScheme: SwiftDownloadKit.HTTPScheme{
        switch self{
        case .mockInvalidAPIEndpoint,.mockValidAPIEndpoint,.mockBytedownloader:
            return .https
        }
    }
    
    var path: String{
        switch self{
        case .mockInvalidAPIEndpoint:
            return "/invalidPath"
        case .mockValidAPIEndpoint:
            return "/posts"
        case .mockBytedownloader(let chunkSize):
            return "/range/\(chunkSize)"
        }
    }
    
    var host: String{
        switch self{
        case .mockInvalidAPIEndpoint:
            return "/invalidPath"
        case .mockValidAPIEndpoint:
            return "jsonplaceholder.typicode.com"
        case .mockBytedownloader:
            return "httpbin.org"
        }
    }
    
    var httpBody: Data?{
        switch self{
        case .mockInvalidAPIEndpoint,.mockValidAPIEndpoint, .mockBytedownloader:
            return nil
        }
    }
    
    var headerParam: [String : String]?{
        switch self{
        case .mockInvalidAPIEndpoint,.mockBytedownloader:
            return nil
        case .mockValidAPIEndpoint:
            return ["signature":"0987656789098765456789098765"]
        }
    }
    
    var queryParams: [URLQueryItem]?{
        switch self{
        case .mockInvalidAPIEndpoint:
            return nil
        case .mockValidAPIEndpoint:
            return [URLQueryItem(name: "expires", value: "667182")]
        case .mockBytedownloader:
            return nil
        }
    }
}
