//
//  ExtratoViewController.swift
//  HttpRequest
//
//  Created by Flavio Rabelo on 18/03/17.
//  Copyright © 2017 FagutApp. All rights reserved.
//

import UIKit

class ExtratoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {

    // MARK: Properties
    @IBOutlet weak var cpdTextField: UITextField!
    @IBOutlet weak var anoPickerView: UIPickerView!
    @IBOutlet weak var anoSemLabel: UILabel!
    
    var pickerData: [[String]] = []
    var pickerValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.anoPickerView.delegate = self
        self.anoPickerView.dataSource = self
        
        pickerData = [["20152", "20161", "20162", "20171"],["20152", "20161", "20162", "20171"]]
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: PickerView
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[0].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[0][row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        anoSemLabel.text = pickerData[0][row]
        self.pickerValue = pickerData[1][row]
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc =  segue.destination as! ViewController
        
        if let cpd = cpdTextField.text {
            if cpd != "" {
                if let anoSemestre = pickerValue {
                    vc.cpd = cpd
                    vc.anoSemestre = anoSemestre
                } else {
                    Alerta.alerta(msg: "Escolha o Ano e Semestre", viewController: self)
                }
            } else {
                Alerta.alerta(msg: "Digite o Cpd!", viewController: self)
            }
        } else {
            Alerta.alerta(msg: "Digite o CPD", viewController: self)
        }

        // Pass the selected object to the new view controller.
    }


}
