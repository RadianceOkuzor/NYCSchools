//
//  APIServices.swift
//  20220127-RadianceOkuzor-NYCSchools
//
//  Created by Radiance Okuzor on 1/27/22.
//

import Foundation


class APIService : NSObject {
    
    // url link that returns the json object
    private let schoolNameURL = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!
     

    // fucntion to communicate with the database and return the json object ready to be parsed with the codable highschool object
    func apiToGetSchoolData(completion : @escaping ([Highschool]) -> () ) {
        URLSession.shared.dataTask(with: schoolNameURL) { (data, urlResponse, error) in
            if error != nil {
                // giving more time and access to server I would love to handle this error and perform tests for different possible errors, and project it to the screen adequatley 
               print("Encountered error: \(error!)")
                return
           } else
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
               do {
                   let hsData = try jsonDecoder.decode([Highschool].self, from: data)
                       // send a response upon completion of the network call
                       completion(hsData)
               } catch {
                   
               }
                
            }
            
        }.resume()
    }
}
