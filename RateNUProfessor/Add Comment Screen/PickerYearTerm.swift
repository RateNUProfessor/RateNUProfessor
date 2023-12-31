//
//  PickerYearTerm.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/30/23.
//

import UIKit

extension AddCommentScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.addCommentScreen.pickerTerm {
            return Term.term.count
        } else if pickerView == self.addCommentScreen.pickerYear {
            return years.count
        }
        return 0 // Default return
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.addCommentScreen.pickerTerm {
            self.selectedTerm = Term.term[row]
            return Term.term[row]
        } else if pickerView == self.addCommentScreen.pickerYear {
            self.selectedYear = years[row]
            return years[row]
        }
       return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.addCommentScreen.pickerTerm {
            self.addCommentScreen.textFieldTerm.text = Term.term[row]
              self.view.endEditing(false)
        } else if pickerView == self.addCommentScreen.pickerYear{
            self.addCommentScreen.textFieldYear.text = years[row]
              self.view.endEditing(false)
        }
    }
}
