//
//  ViewController.swift
//  10AppNews
//
//  Created by djdenielb on 23/04/22.
//

import UIKit
//Importamos el safari services
import SafariServices

class MainViewController: UIViewController {

//    Primero creamos una variable instancia del Articles como array, este es para llenarlo
    var articles = [Article]()
//    Despues una instancia del modelo para usar sus funciones
    var model = Model()
//    Esta variable es para formatear la fecha de la API
    var fechaActual =  Date.now

//    Variable graficas
    @IBOutlet weak var prototypeTable: UITableView!
    
//    Metodo al arrancar
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        En el metodo al arrancar, primero debemos enlazar la celda personalizada a la tabla principal
        prototypeTable.register(UINib(nibName: "NewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        
//        Despues llamamos al delgado del protocolo que pusimos en el model, esto dira que esta clase viewcontroller
//        sera la encargada de usar ese delegado y al ponerlo aqui le indica que al arrancar ejecute las funciones
//        obligatorias del protocolo y lo demas que le pongamos
        model.delegate = self
            
//        Despues de que se ejecutan las funciones del protocolo ponemos el delegado de la tabla uno la llena y el otro
//        la presenta
        prototypeTable.dataSource = self
        prototypeTable.delegate = self
        
//        Despues mandamos a llamar a la funcion que crea la api
        model.ApiCreate()
    }
}

//Hacemos una extension al view controller para agregar el protocolo para la tabla
extension MainViewController: UITableViewDataSource, UITableViewDelegate{

//    Numero de secciones es igual al array que creamos .count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
//    Aqui personalizamos los elementos de la celda con los valores del array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        Creamos una variable cell y la casteamos a la celda personalizada para acceder a sus elementos
        let cell = prototypeTable.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCellTableViewCell
        
//        LLenamos el titulo, el subtitulo y el autor
        cell.labelTitle.text = articles[indexPath.row].title ?? "Sin Titulo"
        cell.labelDescription.text = articles[indexPath.row].description ?? "Sin Contenido"
        cell.labelAuthor.text = articles[indexPath.row].source.name
        
//        Aqui al label de fecha le vamos a dar un formato primero declaramos una variable con la clase dateformatter
        let formatoFecha = DateFormatter()
//        luego a esa variable usamos el metodo local para darle formato de mexico
        formatoFecha.locale = Locale(identifier: "es_MX_POSIX")
//        luego usamos el metodo dateformat para ponerle como queremos que se vea se pone en string
        formatoFecha.dateFormat = "yy, MMM d"
//        luego creamos otra variable que sera igual a la funcion date, y usamos el string que viene de la API
        let fechaFormateada = formatoFecha.date(from: articles[indexPath.row].publishedAt ?? "Sin fecha")
//        Luego creamos otra y le ponemos el metodo string y le pasamos la anterior que ya viene formateada, por que
//        la que viene formateada es de tipo fecha y nosotros necesitamos que sea string
        let fechaString = formatoFecha.string(from: fechaFormateada ?? fechaActual)
//        ahora el label fecha ya le asignamos la que ya este en string
        cell.labelDate.text = fechaString
        
//        Usamos el dispatch para que un metodo que se ejecuta en segundo plano pase el primer plano
        DispatchQueue.main.async {
//             Dentro creamos una variable que sea igual a una url, esta url es la que viene en la api y es el que carga
//            una imagen, pero ya viene con la imagen llenado
            if let imageField = URL(string: self.articles[indexPath.row].urlToImage ?? "" ){
//                Despues creamos otra imagen y este va a ser del tipo data o sea el campo vacio de la imagen de la api
//                se guarda como dato en la variable segura pero ya no esta vacio por que ya lo lleno la funcion del modelo
                if let dataImage = try? Data(contentsOf: imageField){
//                    despues el imageview se llena con ese campo de imagen
                    cell.ivImage.image = UIImage(data: dataImage)
                }
            }
        }
        
//        Retornamos la celda llena
        return cell
    }
    
//    Esta funcion es para que haga algo al seleccionar un elemento
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Cremos una variable que tendra una url que sera la que viene en la API
        guard let urlMandar = URL(string: articles[indexPath.row].url ?? "") else {return}
//        Creamos una variable que hara uso del safari view controller y recibe como parametro la url de la API
        let vcSS = SFSafariViewController(url: urlMandar)
//        Presenta la variabl del safari controller
        present(vcSS, animated: true, completion: nil)
        
    }
}

//Esta extension es para usar el protocolo que creamos en el model
extension MainViewController: ModelProtocol{
//    la funcion obligatoria recibe un objeto lleno, este objeto es un array de atributos que se encarga de llenar
//    la funcion de crear una API
    func actualizarUI(recibeObjetoPaises: [Article]) {
//        la variable que creamos la llenbamos con que recibe esta funcion
        articles = recibeObjetoPaises
//        Despues actualizamos la tabla despues de que se llena
        prototypeTable.reloadData()
    }
    
    
}

