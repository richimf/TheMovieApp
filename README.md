# The Movie App

### por Ricardo Montesinos

![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/p1.png)
![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/p2.png)
![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/p3.png)
![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/p4.png)

## How to use

Ira a la carpeta `/TheMovieApp`, y ejecutar via terminal:

> pod install

una vez instalado terminar abrir `TheMovieApp.xcworkspace`.

O bien, todo junto:

> pod install & open TheMovieApp.xcworkspace

Finalmente ejecutar la app **Build and Run**.

# Proyecto

### Generalidades

El proyecto se pensó para desarrollarse con la **mayor independencia** a librerias de terceros, incluyen los siguientes features generales:

- **Dependencias**:
	- Alamofire
	- ObjectMapper
	- Lottie
	- Youtube Player
	- Core Data para local storage y NSCache para imágenes 


Así mismo incluye las carácteristicas solicitadas.

- **Features solicitados**:
	- Consumir el API de películas y series **Done**
	- Debe tener tres categorías            **Done**
	- Visualizar su detalle                 **Done**
	- Buscador offline por categorías       **Done**

- **Además**:

	- Almacenamiento en **CACHE** de imagenes descargadas de Internet
	- Almacenamiento Local via **CoreData**
	- Arquitectura general: **VIPER**
	- Protocol Oriented Programming
	- Functional Programming
	- Manejo asíncrono y thread safe con Core Data
	- Animaciones como Extensions y como Helper.
	- Custom View Transitions
	- ARC checked (referencias **WEAK** entre **Presenter-Interactor**.
	- Patrones de diseño como: Multi Delegate Pattern, Singleton, Observer y State Pattern.

### Estructura

Dentro del proyecto encontramos la siguiente estructura:

- **DataManager**: Encargado del almacenamiento de los datos en el dispositivo. Tanto para imagenes como para películas y géneros.

- **APIManager**: Contiene dos archivos.
	- **APIClient**:  Se encarga de los HTTP Request hacia el API.
	- **APIConstants**: Valores necesarios para los Requests.

- **Resources**: Esta carpeta incluye tipografia, **UIControls**, **Helpers de Animacion**, el Loader inicial de **Lottie** y además de **Extensiones** a componentes de UIKit.

- **Modules**: Son las vistas de la App.
	-  **Catalog**: Vista principal, la lista de películas, incluye búsqueda y un segmented control para navegación rápida entre las tres categorias principales Popular, Top Rated y Upcoming.
	-  **MovieDetail**: Vista de detalle de la película o serie, permite reproducir video y da información básica.
	-  **CategoryFilter**: Vista de Géneros para filtrar.
	-  **VideoPlayerPreview**: Una vista de previsualización de video que es posible utilizar desde la vista principal.


## Arquitéctura VIPER

Se enfocó la arquitectura en dos modulos principalmente:

- **Catalog**: Lista de películas, vista principal.
- **MovieDetail**: Vista de detalle.

### Catalog:

- **Protocols**: Es la carpeta que contiene la clase **CatalogProtocols** que a su vez contiene todos los Protocolos de **VIPER** .

- **DataManager**: 

	- **CacheDataManager** que se encarga del **Cache** de Imagenes descargadas y almacenamiento Local.
	
	- **ImageDownloader**: Clase encargada de descargar y comprimir imágenes.

- **Interactor**: Esta clase **CatalogInteractor** es el intermediario para los Request, descarga de Películas e Imagenes y peticiones al almacenamiento Local. Se encarga de Notificar al Presenter.

- **Presenter**: La clase **CatalogPresenter** es la capa intermedia entre la Vista y el Interactor. Además de comunciarse con el **Router** para navegar a nuevas vistas.

- **View**: Esta carpeta incluye el **ViewController** del módulo y elementos de vista en general.

- **Entities**: Son los objetos de Mappeo utilizados en el *response* para poblar la vista, esto son **MovieResults**, **Movie**, **Genres** y **Genre**. Todos objetos *Mappeables*.

- **Router**: Contiene la clase **CatalogRouter** que nos permite la conexíon y navegación con otras vistas (módulos) de la App.


### MovieDetail:

Dentro de esté módulo tenemos lo siguiente:

- **Protocols**: Es la carpeta que contiene todos los **Protocolos** de **VIPER** dentro de la clase **MovieDetailProtocols**.

- **View**: Esta carpeta incluye el **ViewController** del módulo y elementos de vista en general.

- **Presenter**: Esta carpeta incluye la clase **MovieDetailPresenter** que es el Presenter de este módulo.

- **Entities**: Incluye dos entidades **Video** y **VideoDetails** que se utilizan en la respuesta del *KEY* para visualizar videos de Youtube.

## Vistas adicionales

Tenemos dos vistas que **NO** se incluyen en VIPER por su simplicidad, se prefirió optar por el criterio de simplicidad, sin embargo obedece VIPER y son invocadas desde el ROUTER del módulo **Catalog**, estas son:

- **CategoryFilterViewController**: Vista de filtros por género.
- **VideoPlayerViewController**: Vista de reproductor de video.

## Preguntas
   
# 1.- ¿En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito?
   
   Este principio establece que cada clase, función, estructura o bloque de código tiene una tarea. El propósito es tener una arquitectura limpia, que al modificar un bloque de código el impacto sea grande y limpio. Esto además permite reutilizar y crear capas para el mejor mantenimiento.
      
# 2.- ¿Qué características tiene, según su opinión, un “buen” código o código limpio?

   Un buen código comienza desde que es legible, variables simples, comentado, enfocado a las estructuras de datos mas que a las librerias o el lenguaje. Envitar errores de ausencia de datos `nil values`. 
    Detectar si el código se repite mucho, entonces es factible una refactorización y quizas el uso de patrones de diseño pueda ser una solución *(sin caer en los antipatrones)*. La declaración explicita de datos, con el fin de ser claros en nuestros valores y evitar inferencia de tipos, entre otras técnicas. Respetar la arquitectura establecida. Y el uso de Unit Tests para asegurar el funcionamiento correcto del proyecto. 

## Screenshots

![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/1.gif)
![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/2.gif)
![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/3.gif)
![ScreenShot](https://github.com/richimf/TheMovieApp/blob/develop/screenshots/4.gif)
