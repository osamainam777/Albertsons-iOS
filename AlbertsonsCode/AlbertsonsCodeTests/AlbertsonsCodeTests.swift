//
//  AlbertsonsCodeTests.swift
//  AlbertsonsCodeTests
//
//  Created by Usama Inaam Rasheed on 1/26/23.
//

import XCTest
@testable import AlbertsonsCode

final class AlbertsonsCodeTests: XCTestCase {
    
    var viewModel: CatViewModel?


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel = CatViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    ///Failure: Cat Fact test case
    func testLoadingFactsDataFailure() throws {
        viewModel?.loadCatFacts(url: "Failure/URL", completion: { factDatasource, statusCode  in
            XCTAssertTrue(statusCode == 400)
            XCTAssertNil(factDatasource?.data)
        })
    }
    
    ///Success: Cat Fact Test case
    func testLoadFactData() throws {
        viewModel?.loadCatFacts(completion: { factDatasource, statusCode in
            XCTAssertTrue(statusCode == 200)
            XCTAssertNotNil(factDatasource?.data)
        })
    }
    
    ///Success: Cat Image Test case
    func testLoadImagesData() throws {
        viewModel?.downloadImage()
        XCTAssertNotNil(viewModel?.catImage)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
