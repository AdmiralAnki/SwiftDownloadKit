//
//  FileHandler.swift
//  
//
//  Created by Ankith K on 06/01/24.
//

import Foundation

public class FileHandler {
    
    var fileManager: FileManager
    var directory: URL
    
    public init(fileManager: FileManager, directory: URL) {
        self.fileManager = fileManager
        self.directory = directory
    }
    
    public func writeData(_ data: Data, toFileName fileName: String) throws {
        let fileURL = directory.appendingPathComponent(fileName)
        try data.write(to: fileURL, options: .atomic)
    }

    public func appendData(_ data: Data, toFileName fileName: String) throws {
        let fileURL = directory.appendingPathComponent(fileName)
        if !fileManager.fileExists(atPath: fileURL.path) {
            try data.write(to: fileURL, options: .atomic)
            return
        }
        
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        } else {
            throw FileError.fileHandlerFailed
        }
    }
    
    public func readData(fromFileName fileName: String) throws -> Data {
        let fileURL = directory.appendingPathComponent(fileName)
        return try Data(contentsOf: fileURL)
    }
}
