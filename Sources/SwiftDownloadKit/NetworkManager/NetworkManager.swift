//
//  NetworkManager.swift
//  
//
//  Created by Ankith K on 06/01/24.
//

import Foundation
import Networking

public class NetworkManager{
    
    private init(){}
    
    public static let shared = NetworkManager()
    
    public func performNetworkCall(session:URLSession,urlRequest:URLRequest) async -> Result<(Data,URLResponse),Error> {
        do{
            let result = try await session.data(for: urlRequest)
            return .success(result)
        }catch{
            return .failure(error as? NetworkError ?? .connectionError )
        }
    }
    
    public func fetchRangeList(size:Int,downloaded:Int,chunkSize:Int)->[String]{
        
        guard downloaded < size else {return []}
        
        var rangeList = [String]()
        var (start, end, range) = fetchNextRange(size: size, downloaded: downloaded, chunkSize: chunkSize)
        rangeList.append(range)
        
        while(end != size){
            (start,end,range) = fetchNextRange(size: size, downloaded: end, chunkSize: chunkSize)
            rangeList.append(range)
        }
        
        return rangeList
    }
    
    public func fetchNextRange(size:Int,downloaded:Int,chunkSize:Int)->(Int,Int,String){
        let start = (downloaded == 0 ? downloaded : downloaded+1)
        let end = (start+chunkSize > size ? size : start+chunkSize)
        
        return (start:start,end:end,range:"\(start)-\(end)")
    }
}
