//
//  SolicitudesTableController.swift
//  UnTaxi
//
//  Created by Done Santana on 4/3/17.
//  Copyright © 2017 Done Santana. All rights reserved.
//

import UIKit

class SolicitudesTableController: UITableViewController {
  
  var solicitudesMostrar = [Solicitud]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.tintColor = UIColor.black
    self.solicitudesMostrar = GlobalVariables.solpendientes
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func mostrarMotivosCancelacion(solicitud: Solicitud){
    let motivoAlerta = UIAlertController(title: "", message: "Seleccione el motivo de cancelación.", preferredStyle: UIAlertController.Style.actionSheet)
    motivoAlerta.addAction(UIAlertAction(title: "No necesito", style: .default, handler: { action in
      self.CancelarSolicitud("No necesito", solicitud: solicitud)
    }))
    motivoAlerta.addAction(UIAlertAction(title: "Demora el servicio", style: .default, handler: { action in
      self.CancelarSolicitud("Demora el servicio", solicitud: solicitud)
    }))
    motivoAlerta.addAction(UIAlertAction(title: "Tarifa incorrecta", style: .default, handler: { action in
      self.CancelarSolicitud("Tarifa incorrecta", solicitud: solicitud)
    }))
    motivoAlerta.addAction(UIAlertAction(title: "Vehículo en mal estado", style: .default, handler: { action in
      self.CancelarSolicitud("Vehículo en mal estado", solicitud: solicitud)
    }))
    motivoAlerta.addAction(UIAlertAction(title: "Solo probaba el servicio", style: .default, handler: { action in
      self.CancelarSolicitud("Solo probaba el servicio", solicitud: solicitud)
    }))
    motivoAlerta.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.destructive, handler: { action in
      
    }))
    
    self.present(motivoAlerta, animated: true, completion: nil)
  }
  
  func CancelarSolicitud(_ motivo: String, solicitud: Solicitud){
    //#Cancelarsolicitud, idSolicitud, idTaxi, motivo, "# \n"
    //let temp = (GlobalVariables.solpendientes.last?.idTaxi)! + "," + motivo + "," + "# \n"
    let datos = GlobalVariables.solpendientes.last?.crearTramaCancelar(motivo: motivo)
    GlobalVariables.solpendientes.removeAll{$0.id == solicitud.id}
    if GlobalVariables.solpendientes.count == 0 {
      GlobalVariables.solicitudesproceso = false
    }
    if motivo != "Conductor"{
      let vc = R.storyboard.main.inicioView()!
      vc.EnviarSocket(datos!)
      self.navigationController?.show(vc, sender: nil)
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.solicitudesMostrar.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //let cell = tableView.dequeueReusableCell(withIdentifier: "Solicitudes", for: indexPath)
    let cell = Bundle.main.loadNibNamed("SolPendientesCell", owner: self, options: nil)?.first as! SolPendientesViewCell
    cell.initContent(solicitud: self.solicitudesMostrar[indexPath.row])
    //cell.textLabel?.text = self.solicitudesMostrar[indexPath.row].fechaHora
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let solicitud = self.solicitudesMostrar[indexPath.row]
    if solicitud.idTaxi != "null" && solicitud.idTaxi != ""{
      let vc = R.storyboard.main.solPendientes()!
      //vc.solicitudPendiente = self.solicitudesMostrar[indexPath.row]
      vc.solicitudIndex = indexPath.row
      self.navigationController?.show(vc, sender: nil)
    }else{
      let alertaDos = UIAlertController (title: "Solicitud en proceso", message: "Solicitud enviada a todos los taxis cercanos. Esperando respuesta de un conductor.", preferredStyle: .alert)
      alertaDos.addAction(UIAlertAction(title: "Esperar respuesta", style: .default, handler: {alerAction in
        let vc = R.storyboard.main.inicioView()!
        self.navigationController?.show(vc, sender: nil)
      }))
      alertaDos.addAction(UIAlertAction(title: "Cancelar la solicitud", style: .destructive, handler: {alerAction in
        self.mostrarMotivosCancelacion(solicitud: solicitud)
      }))
      self.present(alertaDos, animated: true, completion: nil)
    }
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
