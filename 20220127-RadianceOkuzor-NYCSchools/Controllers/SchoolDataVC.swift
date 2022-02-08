//
//  SchoolDataVC.swift
//  20220127-RadianceOkuzor-NYCSchools
//
//  Created by Radiance Okuzor on 1/27/22.
//

import UIKit

class SchoolDataVC: UIViewController {
    
    var highSchool:Highschool = Highschool()
    
    // used to change animation of the graph
    @IBOutlet weak var mathHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var readingHeight: NSLayoutConstraint!
    @IBOutlet weak var writingHeight: NSLayoutConstraint!
    @IBOutlet weak var mathView: UIView!
    @IBOutlet weak var readingView: UIView!
    @IBOutlet weak var writingView: UIView!
    @IBOutlet weak var imageG: UIImageView!
    
    // labels that show school specific data
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // set custom fonts for uilabels
        setFonts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // animate the chart right before view appears
        animateGraph()
        imageG.image = UIImage.gifImageWithName("bkGround")
    }
    
    func animateGraph() {
        
        // get the sat scores of the subjects
        let mathScore = Int(self.highSchool.mathScore) ?? 1
        
        let readingScore = Int(self.highSchool.readingScore) ?? 1
        
        let writingScore = Int(self.highSchool.writingScore) ?? 1
        
        // create labels to show the exact score number per subject
        // the x equation centers the label in the middle of the bar chart
        let mathScoreLabel = XLabel(frame: CGRect(x: (mathView.frame.width/2)-17, y: 0, width: 60, height: 35))
        mathScoreLabel.titleLable()
//        mathScoreLabel.textColor = .
        mathView.addSubview(mathScoreLabel)
        mathView.addTopBorder()
        
        let readingScoreLabel = XLabel(frame: CGRect(x: (readingView.frame.width/2)-17, y: 0, width: 60, height: 35))
        readingScoreLabel.titleLable()
        readingView.addSubview(readingScoreLabel)
        readingView.addTopBorder()
        
        let writingScoreLabel = XLabel(frame: CGRect(x: (writingView.frame.width/2)-17, y: 0, width: 60, height: 35))
        writingScoreLabel.titleLable()
        writingView.addTopBorder()
        writingView.addSubview(writingScoreLabel)
         
        UIView.animate(withDuration: 1) {
            self.mathHeightConstraint.constant = CGFloat(mathScore/2)
            self.mathView.frame.size.height =  CGFloat(-mathScore/2)
            mathScoreLabel.animateCount(endCount: mathScore)
        }
        
        UIView.animate(withDuration: 1.5) {
            self.readingHeight.constant = CGFloat(readingScore/2)
            self.readingView.frame.size.height = CGFloat(-readingScore/2)
            readingScoreLabel.animateCount(endCount: readingScore)
        }
        
        UIView.animate(withDuration: 2.0) {
            self.writingHeight.constant = CGFloat(writingScore/2)
            self.writingView.frame.size.height = CGFloat(-writingScore/2)
            writingScoreLabel.animateCount(endCount: writingScore)
        }
    }
    
    func setFonts(){
        self.title = "HOMIE Assessment"
        schoolNameLabel.text = highSchool.schoolName
        schoolNameLabel.titleLable()
        mathLabel.midLable()
        writingLabel.midLable()
        readingLabel.midLable()
    }
    
   
 
}

