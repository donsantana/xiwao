//
//  TipoVehiculoCell.swift
//  Xiwao
//
//  Created by Donelkys Santana on 8/8/20.
//  Copyright © 2020 Done Santana. All rights reserved.
//

import UIKit


class TipoVehiculoCell: UITableViewCell{
  var tipoVehiculo = 0
  @IBOutlet weak var tipoVehiculoPicker: UIPickerView!
  
  
  func initContent(){
    self.tipoVehiculoPicker.delegate = self
    self.tipoVehiculoPicker.dataSource = self
  }
  
}

extension TipoVehiculoCell: UIPickerViewDelegate, UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
  }
      
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return GlobalVariables.tipoVehiculoList.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return GlobalVariables.tipoVehiculoList[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.tipoVehiculo = row + 1
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

      var title = UILabel()
         if let view = view {
                title = view as! UILabel
          }
        title.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        title.textColor = UIColor.gray
        title.text =  GlobalVariables.tipoVehiculoList[row]
        title.textAlignment = .left

    return title

    }

}
