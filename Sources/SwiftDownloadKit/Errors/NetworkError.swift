//
//  NetworkError.swift
//  
//
//  Created by Ankith K on 09/01/24.
//

import Foundation

public enum NetworkError:Error{
    case requestCreationFailed
    case invalidEndpoint
    case noResponse
    case connectionError
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
}


extension NetworkError:LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .requestCreationFailed:
            return "Failed to create request due to invalid URL."
        case .invalidEndpoint:
            return "The endpoint URL is invalid."
        case .noResponse:
            return "No response received from the server."
        case .connectionError:
            return "Network connection error."
        case .invalidResponse:
            return "Invalid response from the server."
        case .decodingError:
            return "Failed to decode the response."
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)."
        
        }
    }
}
