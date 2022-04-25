//
//  ViewController.swift
//  10AppNews
//
//  Created by djdenielb on 23/04/22.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {
    
    var model = Model()
    
    var fechaActual =  Date.now

    @IBOutlet weak var prototypeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print("Inicia aqui")
        prototypeTable.register(UINib(nibName: "NewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        
        model.ApiCreate(recibeString: "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx")
            
        prototypeTable.dataSource = self
        prototypeTable.delegate = self
        prototypeTable.reloadData()
        
        
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.arrayArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prototypeTable.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCellTableViewCell
        
        cell.labelTitle.text = model.arrayArticles[indexPath.row].title ?? "Sin Titulo"
        cell.labelDescription.text = model.arrayArticles[indexPath.row].description ?? "Sin Contenido"
        cell.labelAuthor.text = model.arrayArticles[indexPath.row].source.name
        
        let formatoFecha = DateFormatter()
        formatoFecha.locale = Locale(identifier: "es_MX_POSIX")
        formatoFecha.dateFormat = "yy, MMM d"
        let fechaFormateada = formatoFecha.date(from: model.arrayArticles[indexPath.row].publishedAt ?? "Sin fecha")
        
        let fechaString = formatoFecha.string(from: fechaFormateada ?? fechaActual)
        
        cell.labelDate.text = fechaString
        
        if let imageField = URL(string: model.arrayArticles[indexPath.row].urlToImage ?? "" ){
            if let dataImage = try? Data(contentsOf: imageField){
                cell.ivImage.image = UIImage(data: dataImage)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlMandar = URL(string: model.arrayArticles[indexPath.row].url ?? "") else {return}
        let vcSS = SFSafariViewController(url: urlMandar)
        present(vcSS, animated: true, completion: nil)
        
    }
    
    
}

