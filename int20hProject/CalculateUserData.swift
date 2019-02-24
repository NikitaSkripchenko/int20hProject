
import Foundation
import UIKit

class CalculateUserData: UIViewController {
    
    
    @IBOutlet weak var userWeight: UITextField!
    
    @IBOutlet weak var userAge: UITextField!
    
    @IBOutlet weak var genderPicker: UITextView!
    
    @IBOutlet weak var userHeight: UITextField!
    
    @IBOutlet weak var proteinValue: UITextField!
    
    @IBOutlet weak var saltValue: UITextField!
    
    @IBOutlet weak var fatValue: UITextField!

    @IBOutlet weak var sugarValue: UITextField!
    
    @IBOutlet weak var kcalValue: UITextField!
    
    @IBOutlet weak var carbohydratesValue: UITextField!
   
    
    
    @IBAction func calculateUserData(_ sender: UIButton) {
        
        calcFormula()
       
       
    }
    
    func calcFormula(){
        let weight = userWeight.text!
        let age = userAge.text!
        let height = userHeight.text!



        if genderPicker.text! == "Male"{
          
            let ex1 = 13*Int(weight)!
            let ex2 = 5*Int(height)!
            let ex3 = 6*Int(age)!
           let BMRm = 88 + ex1+ex2-ex3
            setValues(kcal: BMRm)
        }else{
            let ex1 = 9*Int(weight)!
            let ex2 = 3*Int(height)!
            let ex3 = 4*Int(age)!
           let BMRf = 448+ex1+ex2-ex3
            setValues(kcal: BMRf)
        }
       
        viewWillAppear(true)
        
    }

    func setValues(kcal:Int){
        let protVal = kcal*25/100
        let fatVal = kcal*30/100
        let carbohydratesVal = kcal*40/100
        let sugarVal = 25
        let saltVal = 2
        kcalValue.text = String(kcal)
        proteinValue.text = String(protVal)
        fatValue.text = String(fatVal)
        carbohydratesValue.text = String(carbohydratesVal)
        sugarValue.text = String(sugarVal)
        saltValue.text = String(saltVal)
        
    }
    
    @IBAction func sendUserData(_ sender: UIButton) {
    }
    
    let genreArray = ["Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        genderPicker.inputView = pickerView
        
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
}


extension CalculateUserData: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return genreArray.count
    }
}

extension CalculateUserData: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return genreArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        genderPicker.text = genreArray[row]
    }
}

