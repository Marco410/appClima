//
//  ViewController.swift
//  Clima
//
//  Created by Marco Castañeda on 23/11/20.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, ClimaManagerDelegate {
    func huboError(cualError: Error) {
        print(cualError.localizedDescription)
        
        DispatchQueue.main.async {
            self.labelDescription.text = cualError.localizedDescription
        }
        
    }
    
    
    func acttualizarClima(clima: ClimaModelo) {
       
        
        DispatchQueue.main.async {
            self.labelCiudad.text = clima.nombreCiudad
            self.labelTemp.text = clima.temperaturaDecimal
            self.labelDescription.text = clima.descripcion
            self.imageFondo.image = UIImage(named: clima.condicionClima)
        }
        
    }
    
    var climaManager = ClimaManager()
    
    @IBOutlet weak var imageFondo: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelCiudad: UILabel!
    @IBOutlet weak var txtBuscar: UITextField!
    @IBOutlet weak var imageTemp: UIImageView!
    @IBOutlet weak var labelTemp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        climaManager.delegado = self
        
        txtBuscar.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        labelCiudad.text = txtBuscar.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (txtBuscar.text != "") {
            
            return true
        }else{
            txtBuscar.placeholder = "Escribe una ciudad para buscar el clima"
            return false
        }
    }

    @IBAction func btnBuscar(_ sender: UIButton) {
        labelCiudad.text = txtBuscar.text
        
        climaManager.fetchClima(nombreCiudad: txtBuscar.text!)
    }
    
}

