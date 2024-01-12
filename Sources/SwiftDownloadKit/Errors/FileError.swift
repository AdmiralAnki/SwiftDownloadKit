//
//  FileError.swift
//
//
//  Created by Ankith K on 12/01/24.
//

import Foundation

public enum FileError:Error{
    case fileHandlerFailed
}

extension FileError:LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .fileHandlerFailed:
            return "Unable to create file handle for appending."
        
        }
    }
}
