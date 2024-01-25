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
    
    
    func testMockByteRequest() throws{
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockBytedownloader(500))
        
        XCTAssertNotNil(request)
    }
    
    func testMockByteRequestMethod() throws{
        let request = NetworkManager.shared.configureRequest(endpoint: MockAPIEndpoints.mockBytedownloader(500))
        
        XCTAssertTrue(request?.httpMethod == "GET")
    }   
    
    func testRangeFetcher(){
        let (_,_,range) = NetworkManager.shared.fetchNextRange( size:3333,downloaded:124,chunkSize:600)
        
        XCTAssert((!range.isEmpty))
    }
    
    func testRangeFetcherStartAtZero(){
        let (start,end,range) = NetworkManager.shared.fetchNextRange( size:85088,downloaded:0,chunkSize:6400)
        
        XCTAssertEqual(start, 0)
        XCTAssertEqual(end, 6400)
        XCTAssertEqual(range, "0-6400")
    }
    
    func testRangeFetcherStartAtRandom(){
        
        let (start,end,range) = NetworkManager.shared.fetchNextRange( size:85088,downloaded:6400,chunkSize:6400)
        
        XCTAssertEqual(start, 6401)
        XCTAssertEqual(end, 12801)
        XCTAssert(range == "6401-12801")
    }
    
    func testRangeFetcherLargeChunk(){
        
        let (start,end,range) = NetworkManager.shared.fetchNextRange( size:1000,downloaded:0,chunkSize:5000)
        
        XCTAssertEqual(start, 0)
        XCTAssertEqual(end, 1000)
        XCTAssert(range == "0-1000")
    }
    
    
    func testRangeListFetcher(){
        
        let rangeTwo = NetworkManager.shared.fetchRangeList( size:6000,downloaded:0,chunkSize:1000)
        
        XCTAssert(!rangeTwo.isEmpty)
    }
    
    func testRangeDownloaded(){
        let rangeTwo = NetworkManager.shared.fetchRangeList( size:1000,downloaded:1000,chunkSize:6400)
        
        XCTAssert(rangeTwo.isEmpty)
    }
    
    func testAlmostComplete(){
        let rangeTwo = NetworkManager.shared.fetchRangeList( size:5000,downloaded:4500,chunkSize:1000)
        XCTAssertEqual(rangeTwo.last, "4501-5000")
    }
    
    func testRealWorldData(){
        let rangeTwo = NetworkManager.shared.fetchRangeList( size:1340287,downloaded:204832,chunkSize:6400)
        
        XCTAssertEqual(rangeTwo.last, "1337810-1340287")
    }
       
}

