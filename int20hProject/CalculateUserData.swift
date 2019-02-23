
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
    
    @IBOutlet weak var carbohydratesValue: UITextField!
    
    @IBOutlet weak var sugarValue: UITextField!
    
    @IBOutlet weak var kilocalories: UITextField!
    
    
    @IBAction func calculateUserData(_ sender: UIButton) {
        
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

