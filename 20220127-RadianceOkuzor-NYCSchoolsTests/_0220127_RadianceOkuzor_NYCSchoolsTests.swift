//
//  _0220127_RadianceOkuzor_NYCSchoolsTests.swift
//  20220127-RadianceOkuzor-NYCSchoolsTests
//
//  Created by Radiance Okuzor on 1/27/22.
//

import XCTest
@testable import _0220127_RadianceOkuzor_NYCSchools

class _0220127_RadianceOkuzor_NYCSchoolsTests: XCTestCase {

    private var highSchoolViewModel : HighSchoolViewModel!
    var highschools:[Highschool] = [Highschool]() // collection of all the schools
    
    // testing to ensure the network request still works as expected
    func testHighschoolHasData(){
        self.highSchoolViewModel = HighSchoolViewModel()
        self.highSchoolViewModel.bindHighSchoolViewModelToController = {
            self.updateDataSource()
            XCTAssertNotNil(self.highschools)
        }
        
    }
    // verifying the filtering still works and produces a result
    func testFiltering(){
        self.highSchoolViewModel = HighSchoolViewModel()
        self.highSchoolViewModel.bindHighSchoolViewModelToController = {
            self.updateDataSource()
            XCTAssertNotNil(self.highSchoolViewModel.filterSchools(filter: "alphabetical"))
        }
        
    }
    // making the caching still works as expected
    func testCaching(){
        self.highSchoolViewModel = HighSchoolViewModel()
        self.highSchoolViewModel.bindHighSchoolViewModelToController = {
            self.updateDataSource()
            XCTAssertNotNil(self.highSchoolViewModel.cacheData())
        }
        
    }
    
    func updateDataSource(){
        highschools = self.highSchoolViewModel.highschoolData
    }

}
