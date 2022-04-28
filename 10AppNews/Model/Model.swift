//
//  Model.swift
//  10AppNews
//
//  Created by djdenielb on 23/04/22.
//

import Foundation

//Se implementa un protocolo con la funcion que va a actualizar la pantall, esta va a se va ejecutar y va a llamar
//A la otra funcion
//Recibe como parametro un array del tipo Article que es el que trae los atributos que vamos a mostrar en pantalla
protocol ModelProtocol{
    func actualizarUI(recibeObjetoPaises: [Article])
}

//Esta es la struct del modelo que sera el encargado de decodificar la API
struct Model{

//    Variabel delegado que sera del tipo model protocol y sera la encargada de ejecutar la funcion de actualizaUI
//    Desde donde sea llamada
    var delegate: ModelProtocol?
    
//    Funcion para crear la url de la API
    func ApiCreate(){
//        Primero se crea una variable con la url de la api
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
//        Despues con esa url se crea una variable segura URL a partir de string
        if let urlAPartirDeUrlString = URL(string: urlString){
//            Despues se crea una variable segura del tipo dara, esta contendra los datos en string de la url, o sea
//            los campos de la api
            if let dataDeLaUrl = try? Data(contentsOf: urlAPartirDeUrlString){
//                Despues se crea una variable segura que tendra lo que decodifica la funcion de abajo, a esta se le
//                pasa la la url que tiene los datos de la api, aun no estan llenos solo los obtiene pero vacios
                if let objetoArticle = decodificaDatosJson(recibeUnData: dataDeLaUrl){
//                    Aqui estamos diciendo que la funcion del protocolo que recibe un array del Article, recibira
//                    el objeto ya llenado cuando termine la funcion de abajo, este delegado se va a llevar ese
//                    objeto lleno junto con la funcion a algun lugar donde lo implementemos
                    delegate?.actualizarUI(recibeObjetoPaises: objetoArticle)
                }
            }
        }
    }
    
//    Este funcion es la que parsea la API, convierte los datos vacios en datos con un tipo de dato y llena el objeto
//    recibe un data o sea los datos o campos vacios y retorna un array del tipo article o sea el objeto lleno
    func decodificaDatosJson(recibeUnData: Data) -> [Article]? {
        
//        Cremos una variable del tipo Article como array para que se pueda llenar
        var articuloNoticia: [Article] = []
//        Creamos una variable como instancia de la clase JSONDecoder para poder usar los metodos de esa clase
        let deco = JSONDecoder()
//        Creamos una variable segura que decodificara el dara de arriba, o sea obtendra acceso a todos los campos del
//        data vacios y los metera ya decidifcados en esta variable segura, se pone welcome, por que ese strcut es el
//        que contiene a los demas, se ponde recibe un data en from por que ese data es el que tiene los campos vacios
//        con la estructura de la api y el deco lo que hara sera llenar los campos con los campos de la api ya con datos
        if let listaElementosQueHabra = try? deco.decode(Welcome.self, from: recibeUnData) {
            
//            Ya teniendo en lista elementos todos los campos decodificados y metidos en sus campos respectivos entonces
//            ahora a la variable de array de arriba le ponemos lo que tiene listaelementos en su atributos (Struct)
//            articles que es la que tiene todos los campos que vamos a imprimir
            articuloNoticia = listaElementosQueHabra.articles
            
//            Retornamos este ultimo array ya llenado
            return articuloNoticia
        }
        
//      Este retorno ya es vacio por que ya estamos retornando el array en el paso anterior
        return nil
}
}
