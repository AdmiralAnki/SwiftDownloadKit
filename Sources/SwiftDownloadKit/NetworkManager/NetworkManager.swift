//
//  NetworkManager.swift
//  
//
//  Created by Ankith K on 06/01/24.
//

import Foundation
public class NetworkManager{
    
    private init(){}
    
    public static let shared = NetworkManager()
    
    
    public func performNetworkCall(endpoint:API,session:URLSession) async -> Result<(Data,URLResponse),Error> {
        do{
            guard let urlRequest = configureRequest(endpoint: endpoint) else {return .failure(NetworkError.requestCreationFailed) }
            
            let result = try await session.data(for: urlRequest)
            return .success(result)
        }catch{
            return .failure(error as! NetworkError)
        }
    }
    
    public func configureRequest(endpoint:API)->URLRequest?{
    
        var urlComp = URLComponents()
        urlComp.scheme = endpoint.httpScheme.rawValue
        urlComp.host = endpoint.host
        urlComp.path = endpoint.path
        urlComp.queryItems = endpoint.queryParams
        
        guard let url = urlComp.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        
        if let params = endpoint.headerParam{
            for (key, value) in params{
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
    
    public func networkManagerTest(){
        print("Network manager checking in!")
    }
}
