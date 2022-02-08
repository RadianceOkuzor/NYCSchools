//
//  Highschool.swift
//  20220127-RadianceOkuzor-NYCSchools
//
//  Created by Radiance Okuzor on 1/27/22.
//

import Foundation

// Model represent simple data structure to hold the schools make it codabel to receive and parse json 

struct Highschool: Codable {
    let schoolName : String
    let readingScore: String
    let mathScore: String
    let writingScore: String
    let numberOfTakers: String
    init() {
        schoolName = ""
        readingScore = ""
        mathScore = ""
        writingScore = ""
        numberOfTakers = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case readingScore = "sat_critical_reading_avg_score"
        case mathScore = "sat_math_avg_score"
        case writingScore = "sat_writing_avg_score"
        case numberOfTakers = "num_of_sat_test_takers"
    }
}
