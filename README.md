# TFG-APIsREST-LinkedData
Este repositorio contiene los avances que se realicen de la asignatura TFG de la UPM en Grado en Ingeniería Informática. Se incluye la memoria de desarrollo y los ficheros necesarios para lanzar las aplicaciones. Para probar las aplicaciones es necesario tener la carpeta descargada de la aplicación que se desea probar. Una vez que se tenga instalado Docker, hay que estar situados en el directorio de la carpeta descargada para poder seguir las instrucciones de lanzamiento y prueba de ejemplos.

## Docker
Herramienta software que nos permite crear, probar e implementar aplicaciones asegurandonos, sea cual sea el entorno donde se requiera usar la aplicación, que siempre funcionará. Esto es posible ya que Docker se basa en contenedores que poseen todo lo necesario (nucleo sistema operativo, código, librerías…). Para obtener Docker debemos de acceder a la página oficial de [Docker](https://docs.docker.com/get-docker/ ) y seguir los pasos de instalación según el sistema operativo que tengamos. Para el desarrollo práctico y prueba de herramientas se ha utilizado Docker para Windows 10 Pro. 

Tendremos que crearnos una cuenta en [Docker Hub](https://hub.docker.com/) para acceder al repositorio de imágenes, que se suelen usar como base para los dockerfile, necesario para lanzar nuestras aplicaciones. 

## Curl
Herramienta de línea de comandos que permite realizar solicitudes HTTP. Permite probar las APIs  sin la necesidad de tener una aplicación web montada.
### Instalación
Se ha utilizado el terminal de Git Bash durante el desarrollo del proyecto para realizar las interacciones con las APIs. Se puede utilizar otros terminales instalando los correspondientes paquetes de Curl. Para instalar Git Bash: 
1.	Visitar la página : https://git-scm.com/downloads
2.	Elegir el sistema en la lista e instalar la configuración descargada
3.	Registrar la ruta del directorio instalable en las variables de entorno.
4.	Abrir Git bash

## PUBBY
### Lanzar aplicación
Geramos la imagén de la aplicación:
```
docker build -t pubby .
```
Lanzamos el contenedor de forma iterativa a traves del puerto 8080 y permitiendo sincronizar el fichero indicado de nuestro host dentro de la imagen:

```
docker run -it -p 8080:8080 -v "$(pwd)/Configuracion:/usr/tmp" pubby
```
Se nos abrirá un Shell Bash para iteracturar con nuestro contenedor. Lanzamos el servelt Tomacat:
```
/usr/local/tomcat/bin/catalina.sh run
```
Con esto ya tendríamos la aplicación Pubby en funcionamiento. Podemos observar el resultado en la ruta http://localhost:8080/

Si deseamos cambiar nuestra configuración bastaría con modificar el fichero “config.ttl” de nuestro directorio de trabajo en host y realizar los siguientes pasos:

* Modificar el fichero config.ttl en nuestro host que se encuentra en el directorio “/Configuracion”

*	Parar la ejecución de Catalina (Tomcat) con ctrl+C en nuestro Shell Bash
*	Ejecutar el siguiente comando para actualizar la configuración en Tomcat : 
    ```
    cp /usr/tmp/config.ttl /usr/local/tomcat/webapps/ROOT/WEB-INF/config.ttl
    ```
* Lanzar de nuevo el servlet Tomcat: 
    ```
    /usr/local/tomcat/bin/catalina.sh run
    ```
### Probar ejemplos
#### 1. Configuración  con endpoint de Wikipedia
En el siguiente ejemplo podemos observar que se utilizara como endpoint DBpedia y se buscará todo los recursos que coincidan con la URI “/resource/Wikipedia”. 
```
@prefix conf: <http://richard.cyganiak.de/2007/pubby/config.rdf#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix geo: <http://www.w3.org/2003/01/geo/wgs84_pos#> .
@prefix dbpedia: <http://localhost:8080/resource/> .
@prefix p: <http://localhost:8080/property/> .
@prefix prvTypes: <http://purl.org/net/provenance/types#> .
@prefix doap:     <http://usefulinc.com/ns/doap#> .
<> a conf:Configuration; 
    conf:projectName "DBpedia.org";
    conf:projectHomepage <http://dbpedia.org>; 
    conf:webBase <http://localhost:8080/>;
    conf:usePrefixesFrom <>;
    conf:defaultLanguage "es";
    conf:indexResource <http://dbpedia.org/resource/Wikipedia>;
	
    conf:dataset [
        conf:sparqlEndpoint <https://dbpedia.org/sparql>;
        conf:sparqlDefaultGraph <http://dbpedia.org>;
        conf:datasetBase <http://dbpedia.org/resource/>;
    ];
.
```
#### 2. Configuración cargando un RDF 
En este ejemplo podemos observar cómo se carga 2 ficheros RDF, de propiedad de Richar Cyganiak, para exponer los recursos a través de la aplicación Pubby. Además se usan  los prefijos de estos ficheros en la salida. 
```
# Ejemplo de configuración que carga algunos ficheros estáticos RDF de Richard Cyganiak.
# Asumiendo que Pubby está corriendo en http://localhost:8080/
@prefix conf: <http://richard.cyganiak.de/2007/pubby/config.rdf#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
<> a conf:Configuration;
    conf:projectName "Richard Cyganiak's Homepage";
    conf:projectHomepage <http://richard.cyganiak.de/>;
    conf:webBase <http://localhost:8080/>;
	conf:dataset [
	    conf:datasetBase <http://richard.cyganiak.de/>;
	    conf:loadRDF <http://richard.cyganiak.de/foaf.rdf>;
	    conf:loadRDF <http://richard.cyganiak.de/cygri.rdf>;
	];
    conf:usePrefixesFrom <http://richard.cyganiak.de/foaf.rdf>;
    conf:usePrefixesFrom <http://richard.cyganiak.de/cygri.rdf>;
    conf:labelProperty rdfs:label, dc:title, foaf:name;
    conf:indexResource <http://richard.cyganiak.de/foaf.rdf#cygri>;
    .
```

## BASIL
### Lanzar aplicación
Geramos la imagén de la aplicación:
```
docker build -t basil .
```
Lanzamos el contenedor de forma iterable a través del pruerto 8080:
```
docker run -it -p 8080:8080 basil
```
Se nos abrirá un Shell Bash para iteracturar con nuestro contenedor. Arrancamos nuestro servidor mysql
```
service mysql start
```
Una vez arrancado nuestra base de datos, ejecutamos el script "run.sh" en segundo plano
```
./run.sh &
```
Debemos de obtener el control de la consola con “ctrl+c”. Podemos comprobar con el comando “ps -u” que nuestro proceso sigue funcionando. Con esto ya tendríamos la aplicación Basil en funcionamiento y lista para usar. Para crear y gestionar nuestras APIs se deberá de realizar a través del comando “curl”. La aplicación se ejecuta en http://localhost:8080/

### Probar ejemplos
Una vez lanzada la aplicación podemos probar los siguientes ejemplos lanzando los comandos ,desde el terminal Shell Bash en la ruta raíz, en el orden correspondiente.  
Una vez realizados los ejemplos podemos comprobar que los datos se han ido guardado en nuestra base de datos. 
1.	Debemos de identificarnos con las credenciales de nuestro servidor mysql
  ```
  mysql --host=localhost --user=root --password=jose
  ```
Se nos abrirá un prompt “mysql>” en donde podremos ejecutar sentencias SQL. 
2.	Observamos las bases de datos existentes.
    ```
    mysql> show databases; 
    ```
3.	Seleccionamos la base de datos basil.
    ```
    mysql> use basil;
    ```
4.	Observamos las tablas existentes.
    ```
    mysql> show tables;
    ```
5.	Con esta sentencia podemos seleccionar todo el contenido de la tabla especificada, en este caso de la tabla users.
    ```
    mysql> select * from users;
    ```
#### 1. Creación de API Películas
El objetivo es construir una API sencilla, pudiendo distinguirla con un alias identificativo, que permita buscar las películas de un determinado director.

Los ficheros que se especifican en los siguientes comandos ya estan creados en la imagen de la aplicación. Solo es necesario ejecutar los comandos.

##### 1. Creamos un usuario en la aplicación
```
curl -v -X POST http://localhost:8080/basil/users -d @user1.json --header "Content-Type: application/json"

```
Contenido del fichero "user1.json":
```
{
username:jose,
password:contra123,
email:jose@gmail.com
}
```

##### 2. Creamos nuestra API con nuestra consulta SPARLQ de ejemplo y  endpoint DBpedia
```
curl -u jose:contra123 -X PUT "http://localhost:8080/basil" -H "X-Basil-Endpoint: http://dbpedia.org/sparql" -T query1.sparql 
```
Contenido del fihero "query1.sparql":
```
PREFIX dbo: <http://dbpedia.org/ontology/>
PREFIX dbr: <http://dbpedia.org/resource/>
select ?peliculas
WHERE {
?peliculas dbo:director dbr:Peter_Jackson .
}
```
3. Ponemos un alias a nuestra aplicación por facilidad de identificación
```
curl -u jose:contra123 -X PUT http://localhost:8080/basil/<code_api>/alias      -T <alias.txt>
```
Contenido del fichero "alias.txt": peliculas

4. Lanzamos una consulta GET a nuestra API para obtener todas las peliculas de un determinado Autor
```
curl http://localhost:8080/basil/peliculas/api
```
#### 2. Creación de API paramétrizada y con documentación

##### 1. Se debería de tener creado el usuario en la aplicación como en el ejemplo 1. Usaremos las credenciales de dicho usuario.
##### 2. Creamos nuestra API con una estructura similar al ejemplo 1 pero limitando la salida de peliculas. En este caso la variable SPARQL esta parametrizada a través de la URI.
```
curl -u jose:contra123 -X PUT "http://localhost:8080/basil" -H "X-Basil-Endpoint: http://dbpedia.org/sparql" -T query2.sparql 
```
Contenido del fichero query2.sparql:
```
PREFIX dbo: <http://dbpedia.org/ontology/>
PREFIX dbr: <http://dbpedia.org/resource/>
select ?peliculas
WHERE {
?peliculas dbo:director dbr:Peter_Jackson .
} LIMIT ?_limitador_integer

```

##### 3. Proporcionamos un alias a nuestra API por moyor facilidad de identificación
```
curl -u jose:contra123 -X PUT http://localhost:8080/basil/<code_api>/alias -T <alias2.txt>
```
Contenido del fichero "alias2.txt": peliculas-filtro

##### 4. Subimos documentación de nuestra API
```
curl-u jose:contra123 -X PUT http://localhost:8080/basil/peliculas-filtro/docs -H "X-Basil-Name: Concepts of entity" -T doc.txt
```
Contenido del fichero "doc.txt": El objetivo es crear una API que permita tener parámetros en la URI para realizar las consultas y tener una breve documentación.
Podemos accder a la documentación realizando una peticion GET al endpoint /docs:
```
curl http://localhost:8080/basil/peliculas-filtro/docs
```
##### 5. Realizamos una consulta a nuestra API pasando como parametro en la variable "limitador" el valor 2. Esto permitirá reducir el contenido de nuestros resultados al valor especificado.
```
curl http://localhost:8080/basil/peliculas-filtro/api?limitador=2
```
## Puelia
Lamentablemente esta herramienta no ha podido ser probada con éxito por errores php que aparecen en la salida de la interfaz. Para más información consultar la memoria del proyecto. Se ha subido las aplicaciones y ficheros de configuración que se ha utilizado en la prueba.

## TRELLIS
### Lanzar aplicación
Generamos los contenedores con dockercompose
```
docker-compose up
```
Tendremos la API en funcionamiento. Para crear y gestionar nuestras APIs se deberá de realizar a través del comando “curl”. La aplicación se ejecuta en http://localhost:8080/

### Probar ejemplos

#### 1. Creación de recursos LDP-RS y LDP-NRS en un contendor básico.
El objetivo es almacenar recursos del usuario Raul. En este caso el usuario tiene información sobre su persona y una foto de perfil. Es necesario utilizar para cumplir estos campos un recurso RDF y una imagen (no RDF) respectivamente.

##### 1. Creación contenedor básico para el usuario Pablo
```
curl -s http://localhost:8080 -XPOST -H"Slug: pablo" -H"Link: <http://www.w3.org/ns/ldp#BasicContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/pablo.ttl

```
Contenido del fichero raul.ttl:
```
PREFIX ldp: <http://www.w3.org/ns/ldp#>
PREFIX dc: <http://purl.org/dc/terms/>
<> a ldp:BasicContainer ;
   dc:title "Contenedor Pablo" .

```
##### 2. Creación recurso  RDF con la información del usuario:
```
curl -s http://localhost:8080/pablo/ -XPOST -H"Slug: informacion" -H"Link: <http://www.w3.org/ns/ldp#Resource>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/informacion.ttl

```
Contenido del fichero informacion.ttl:
```
@prefix dc: <http://purl.org/dc/terms/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .

<> a foaf:PersonalProfileDocument;
    foaf:primaryTopic <#me> ;
    dc:title 'Informacion Pablo' .

<#me> a foaf:Person;
    foaf:name 'Pablo';
    foaf:lastName 'Sanchez';
    foaf:interest 'Le apasiona la ingeniería y el futbol'  .


```

##### 3. Creación un recurso no RDF, de tipo imagen, para el avatar del usuario:
```
curl -s http://localhost:8080/pablo/ -XPOST -H"Slug: avatar" -H"Link: <http://www.w3.org/ns/ldp#Resource>; rel=\"type\"" -H"Content-Type: image/jpg" --data-binary @recursos/avatar.jpg

```
##### 4. Resultados:
Realizando una petición Get a  /pablo/ se puede observar que se ha agregado enlaces a los recursos creados con “ldp:contains”: 


#### 2. Uso de contenedores básicos y directos
El objetivo es almacenar recursos de una editorial. Esta editorial almacena publicaciones que contienen RDF libro. Además, usando la propiedad de contendor directo, se indica la creación de tripletas con los atributos membershipResource y hasMemberRelation en el recurso /editorial/escritores

##### 1. Creación contenedor básico para la editorial:
```
curl -s http://localhost:8080 -XPOST -H"Slug: edits" -H"Link: <http://www.w3.org/ns/ldp#BasicContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/editorial.ttl

```
Contenido del fichero editorial.ttl:
```
PREFIX ldp: <http://www.w3.org/ns/ldp#>
PREFIX dc: <http://purl.org/dc/terms/>

<> a ldp:BasicContainer ;
   dc:title "Contenedor Editorial" .
```


##### 2. Creación contenedor directo de una publicación de la editorial:
```
curl -s http://localhost:8080/editorial -XPOST -H"Slug: publicacion1" -H"Link: <http://www.w3.org/ns/ldp#DirectContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/publicacion.ttl

```
Contenido del fichero publicacion.ttl:
```
PREFIX ldp: <http://www.w3.org/ns/ldp#>
PREFIX dc: <http://purl.org/dc/terms/>
PREFIX p: <http://purl.org/saws/ontology#>
<> a ldp:DirectContainer ;
   dc:title "Contenedor Publicacion" ;
   ldp:membershipResource </editorial/escritores> ;
   ldp:hasMemberRelation p:hasWrite .
```

##### 3. Creación contenedor básico de escritores donde se guardan las relaciones que se especifican en el contenedor directo:
```
curl -s http://localhost:8080/editorial -XPOST -H"Slug: escritores" -H"Link: <http://www.w3.org/ns/ldp#BasicContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/escritores.ttl

```
Contenido del fichero escritores.ttl:
```
PREFIX ldp: <http://www.w3.org/ns/ldp#>
PREFIX dc: <http://purl.org/dc/terms/>
<> a ldp:BasicContainer ;
   dc:title "Contenedor Escritores" .

```

##### 4. Creación recurso RDF del libro que se encuentra en publicación:
```
curl -s http://localhost:8080/editorial/publicacion1 -XPOST -H"Slug: libro1" -H"Link: <http://www.w3.org/ns/ldp#Resource>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/libro.ttl

```
Contenido del fichero libro.ttl:
```
@prefix dc: <http://purl.org/dc/terms/> .
@prefix bo: <http://example/books/#> .
<> a bo:Book;
    bo:primaryTopic <#info> ;
    bo:title 'Señor de los anillos' .

<#info> a bo:Book;
    bo:description 'Narra las aventuras de unos Hobbits para destruir un anillo'.
```

##### 5. Resultados:
Realizando una petición GET a /editorial/escritores/ se puede observar que se ha agregado una tripleta al recurso escritores. Como predicado tiene el atributo hasMemberRelation “hasWrite”, especificado en el contenedor directo, y como objeto el libro creado
