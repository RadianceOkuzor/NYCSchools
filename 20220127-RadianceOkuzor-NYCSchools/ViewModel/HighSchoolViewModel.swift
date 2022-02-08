//
//  HighShoolViweModel.swift
//  20220127-RadianceOkuzor-NYCSchools
//
//  Created by Radiance Okuzor on 1/27/22.
//

import Foundation
import Cache

struct User: Codable {
  let firstName: String
  let lastName: String
}

class HighSchoolViewModel: NSObject {
    
    private var apiService : APIService!
    private(set) var highschoolData : [Highschool]! {
        didSet {
            // when this is set with data then the function that binded to this viewmdoel through bindHighschoolviwemoedlTocoonroler is called
            self.bindHighSchoolViewModelToController()
            
            self.cacheIt()

        }
    }
    
    //called by the viewcontroller class and giving an arbitrary indegenous function to be ran 
    var bindHighSchoolViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService() // initialize apiService to be used to get schools data from the back end
        callFuncToGetHSData()
 
    }
    
    func callFuncToGetHSData(){
        // get schools data with the completion
        self.apiService.apiToGetSchoolData { hsData in
            // when this is set it initiates the binding process 
            self.highschoolData = hsData.sorted{$0.schoolName.lowercased() < $1.schoolName.lowercased()}
            let sElements = self.highschoolData.filter{$0.schoolName == "s"}
            self.highschoolData = self.highschoolData.filter{$0.schoolName != "s"} //remove the blank schools
            self.highschoolData.append(contentsOf: sElements) //add the s elements to the bottom
        }
    }
    
    func cacheData() -> [Highschool]{
        let diskConfig = DiskConfig(name: "Disk1")
        let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(86400)), countLimit: 1000, totalCostLimit: 10)
        
        do {
            let storage: Storage<String, [Highschool]> = try Storage<String, [Highschool]>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: [Highschool].self) // Storage<User>
              )
            
            let score = try storage.object(forKey: "hsData")
            return score
        } catch  {
            print("Error with caching data \(error)")
        }
        return []
    }
    
    func filterSchools(filter:String) -> [Highschool] {
        if filter == "alphabetical"{
            highschoolData = highschoolData.sorted{$0.schoolName.lowercased() < $1.schoolName.lowercased()}
            let sElements = highschoolData.filter{$0.schoolName == "s"}
            highschoolData = highschoolData.filter{$0.schoolName != "s"} //remove the blank schools
            highschoolData.append(contentsOf: sElements) //add the s elements to the bottom
        } else if filter == "mathHigh" {
            highschoolData = highschoolData.sorted{$0.mathScore.lowercased() > $1.mathScore.lowercased()}
            let sElements = highschoolData.filter{$0.mathScore == "s"}
            highschoolData = highschoolData.filter{$0.mathScore != "s"} //remove the blank schools
            highschoolData.append(contentsOf: sElements)
        } else if filter == "mathLow"{
            highschoolData = highschoolData.sorted{$0.mathScore.lowercased() < $1.mathScore.lowercased()}
            let sElements = highschoolData.filter{$0.mathScore == "s"}
            highschoolData = highschoolData.filter{$0.mathScore != "s"} //remove the blank schools
            highschoolData.append(contentsOf: sElements) //add the s elements to the bottom
            
        } else if filter == "readingHigh"{
            highschoolData = highschoolData.sorted{$0.readingScore.lowercased() > $1.readingScore.lowercased()}
            let sElements = highschoolData.filter{$0.readingScore == "s"}
            highschoolData = highschoolData.filter{$0.readingScore != "s"} //remove the blank schools
            highschoolData.append(contentsOf: sElements)
            
        } else if filter == "readingLow"{
            highschoolData = highschoolData.sorted{$0.readingScore.lowercased() < $1.readingScore.lowercased()}
            let sElements = highschoolData.filter{$0.readingScore == "s"}
            highschoolData = highschoolData.filter{$0.readingScore != "s"} //remove the blank schools
            highschoolData.append(contentsOf: sElements) //add the s elements to the bottom
            
        } else if filter == "writtingHigh"{
            highschoolData = highschoolData.sorted{$0.writingScore.lowercased() > $1.writingScore.lowercased()}
            let sElements = highschoolData.filter{$0.writingScore == "s"}
            highschoolData = highschoolData.filter{$0.writingScore != "s"} //remove the blank schools
            highschoolData.append(contentsOf: sElements)
            
        } else if filter == "writtingLow"{
            highschoolData = highschoolData.sorted{$0.writingScore.lowercased() < $1.writingScore.lowercased()}
            let sElements = highschoolData.filter{$0.writingScore == "s"}
            highschoolData = highschoolData.filter{$0.writingScore != "s"} //remove the blank schools
            highschoolData.append(contentsOf: sElements) //add the s elements to the bottom
        }
        return highschoolData
    }
    
    func cacheIt(){
        let diskConfig = DiskConfig(name: "Disk1")
        let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(86400)), countLimit: 1000, totalCostLimit: 10)
        
        do {
            let storage: Storage<String, [Highschool]> = try Storage<String, [Highschool]>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: [Highschool].self) // Storage<User>
              )
            try storage.setObject(highschoolData, forKey: "hsData", expiry: .never)
            
        } catch  {
            print("Error with caching data \(error)")
        } 
    }
}
