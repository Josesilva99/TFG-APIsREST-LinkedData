#!/bin/sh
#Creación contenedor básico para la editorial
curl -s http://localhost:8080 -XPOST -H"Slug: editorial" -H"Link: <http://www.w3.org/ns/ldp#BasicContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/editorial.ttl

#Creación contenedor directo de una publicación de la editorial
curl -s http://localhost:8080/editorial -XPOST -H"Slug: publicacion1" -H"Link: <http://www.w3.org/ns/ldp#DirectContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/publicacion.ttl

#Creación contenedor basico de escritores donde se guardan las las relaciones que se especifican en el contenedor directo
curl -s http://localhost:8080/editorial -XPOST -H"Slug: escritores" -H"Link: <http://www.w3.org/ns/ldp#BasicContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/escritores.ttl

#Creación recurso RDF del libro que se encuentra en publicación
curl -s http://localhost:8080/editorial/publicacion1 -XPOST -H"Slug: libro1" -H"Link: <http://www.w3.org/ns/ldp#Resource>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/libro.ttl

