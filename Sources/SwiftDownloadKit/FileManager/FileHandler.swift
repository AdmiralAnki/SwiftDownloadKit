//
//  FileHandler.swift
//  
//
//  Created by Ankith K on 06/01/24.
//

import Foundation

public class FileHandler{
    
    var fileManager :FileManager
    var directory   : URL
    
    public init(fileManager:FileManager,directory: URL) {
        self.fileManager = fileManager
        self.directory = directory
    }
    
    public func writeData(_ data: Data, toFileName fileName: String) throws {
        let fileURL = directory.appendingPathComponent(fileName)
        try data.write(to: fileURL, options: .atomic)
    }
    
    public func readData(fromFileName fileName: String) throws -> Data {
        let fileURL = directory.appendingPathComponent(fileName)
        return try Data(contentsOf: fileURL)
    }
}
