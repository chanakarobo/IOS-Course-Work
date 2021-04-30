

import UIKit
import Firebase

class accViewController: UIViewController {

    
    @IBOutlet weak var frm: UIDatePicker!
    
    
    @IBOutlet weak var to: UIDatePicker!
    
    @IBOutlet weak var infoview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        frm.datePickerMode = .date
        to.datePickerMode = .date
    }
    

    
    @IBAction func searchbtn(_ sender: Any) {
        
      
        
        var set : CGFloat = 20
        Firestore.firestore().collection("orderdetails").whereField("dateTime", isGreaterThanOrEqualTo:  frm.date).whereField("dateTime",isLessThanOrEqualTo:to.date).getDocuments { (snap, error) in
            
            if error != nil
            {
                print("error")
            }
            else
            {
                
               
                    for element in (snap?.documents)! {
                        let data = element.data()
                        
                       
                        let foodnameget =  data["Name"]  as! String
                        let fodqtyget = data["qty"] as! Int
                        let foodunitpriceget = data["unitprice"] as! Float
                        
                        
                        let food = UILabel()

                        food.textAlignment = .center
                        food.text = foodnameget
                        food.textColor = UIColor.black
                        self.infoview.addSubview(food)
                        food.translatesAutoresizingMaskIntoConstraints = false
                        food.leftAnchor.constraint(equalTo: self.infoview.leftAnchor, constant: 30).isActive = true
                        food.topAnchor.constraint(equalTo: self.infoview.topAnchor, constant: set).isActive = true
                        
                        var fixedone :String = String(fodqtyget) + " * " + String(foodunitpriceget)
                        
                        let count = UILabel()

                        count.textAlignment = .center
                        count.text = fixedone
                        count.textColor = UIColor.black
                        self.infoview.addSubview(count)
                        count.translatesAutoresizingMaskIntoConstraints = false
                        count.rightAnchor.constraint(equalTo: self.infoview.rightAnchor, constant: -30).isActive = true
                        count.topAnchor.constraint(equalTo: self.infoview.topAnchor, constant: set).isActive = true
                        
                        
                        set = set + 100
                        
                        
                        
                        
                        
                    }
                    
                
                
               
                
                
                
                
                
                        
                
                
                
                
                
            
                
                
                
                
            }
                    
                    
        }
    }
    
    
    @IBAction func historybtn(_ sender: Any) {
        
        
        
        let info = UIPrintInfo(dictionary: nil)
    info.outputType = UIPrintInfo.OutputType.general
    info.jobName = "Print"
    
    let print = UIPrintInteractionController.shared
        print.printInfo = info
        print.printingItem = infoview.converttoimage()
        print.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
        
        
    }
    
}


extension UIView {
    func converttoimage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let imageconverted = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageconverted!
    }
}

