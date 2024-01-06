import XCTest
@testable import SwiftDownloadKit

final class SwiftDownloadKitTests: XCTestCase {
    
    
    func testConfigureRequestToNil() throws{
        XCTAssertNil(NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockInvalidAPIEndpoint),"Request should be nil for an invalid endpoint")
    }
    
    func testConfigureRequestNonNil() throws{
        XCTAssertNotNil(NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockValidAPIEndpoint),"Request should not be nil for a valid endpoint")
    }
    
    func testConfigureRequestURLComposition() {
//      typealias validEP = MockAPIEndpoints.mockValidAPIEndpoint
        
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockValidAPIEndpoint)
        
        XCTAssertEqual(request?.url?.host, MockAPIEndpoints.mockValidAPIEndpoint.host, "Host in the request should match the endpoint")
        XCTAssertEqual(request?.url?.path, MockAPIEndpoints.mockValidAPIEndpoint.path, "Path in the request should match the endpoint")
    }
    
    func testConfigureRequestWithHTTPSScheme() throws {
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockValidAPIEndpoint)
        
        XCTAssertTrue( request?.url?.scheme == "https")
    }
    
    func testConfigureRequestWithGetMethod() throws{
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockValidAPIEndpoint)
        
        XCTAssertTrue(request?.httpMethod == "GET")
    }
    
    func testConfigureRequestNilHeaderParam() throws{
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockInvalidAPIEndpoint)
        
        XCTAssertNil(request?.allHTTPHeaderFields)
    }
    
    func testConfigureRequestHeaderParam() throws{
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockValidAPIEndpoint)
        
        XCTAssert(request?.allHTTPHeaderFields == MockAPIEndpoints.mockValidAPIEndpoint.headerParam)
    }
    
    func testConfigureRequestNilQueryParam() throws{
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockInvalidAPIEndpoint)
        
        XCTAssertNil(request?.url?.query())
    }
    
    func testConfigureRequestQueryParam() throws{
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockValidAPIEndpoint)
        
      
        guard let url = request?.url,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            XCTFail("Failed to extract query items from the request URL")
            return
        }
        
        
        let expectedQueryParams = MockAPIEndpoints.mockValidAPIEndpoint.queryParams ?? []
        
        for expectedQueryParam in expectedQueryParams {
            guard let actualValue = queryItems.first(where: { $0.name == expectedQueryParam.name })?.value else {
                XCTFail("Query parameter '\(expectedQueryParam.name)' not found")
                return
            }
            
            XCTAssertEqual(actualValue, expectedQueryParam.value, "Value for query parameter '\(expectedQueryParam.name)' is incorrect")
        }
    }
}

