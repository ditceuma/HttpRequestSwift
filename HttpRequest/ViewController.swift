//
//  ViewController.swift
//  HttpRequest
//
//  Created by Flavio Rabelo on 04/12/16.
//  Copyright © 2016 FagutApp. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewController {

    var arrayBoletos: [Boleto] = []
    
    var anoSemestre: String = ""
    var cpd: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeGetCall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeGetCall() {
        // Set up the URL request
        //let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        let todoEndpoint: String = "http://restfin.ceuma.br/WCFRestFin.svc/parcelasAluno/" + self.cpd + "/" + self.anoSemestre
        
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let boletos = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [NSDictionary] else {
                    print("error trying to convert data to JSOn")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                print("The todo is: " + boletos.description)
                
                for boleto in boletos {
                    
                    let boletoLocal: Boleto = Boleto()
                    
                    boletoLocal.codBol = boleto["CodBol"] as? String
                    boletoLocal.anoBol = (boleto["AnoBol"] as! String)
                    boletoLocal.valorParcela = boleto["ValorParcela"] as? Double
                    boletoLocal.dataVencimento = boleto["DataVencimento"] as? String
                    boletoLocal.codigoBolsa = boleto["CodigoBolsa"] as? String
                    
                    print(boletoLocal.anoBol ?? "-")
                    
                    let bolsaArr = boletoLocal.codigoBolsa?.components(separatedBy: "#")
                    boletoLocal.codigoBolsa = bolsaArr?[4]
                    
                    self.arrayBoletos.append(boletoLocal)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }



                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
    
    // MARK: TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBoletos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoletoTableViewCell
        
        cell.anoBolLabel.text = arrayBoletos[indexPath.row].anoBol
        cell.codBolLabel.text = arrayBoletos[indexPath.row].codBol
        cell.valorBolLabel.text = String(describing: arrayBoletos[indexPath.row].valorParcela!)
        cell.vencimentoLabel.text = arrayBoletos[indexPath.row].dataVencimento
        cell.bolsaLabel.text = arrayBoletos[indexPath.row].codigoBolsa

        
        
        return cell
    }
    
    



}

