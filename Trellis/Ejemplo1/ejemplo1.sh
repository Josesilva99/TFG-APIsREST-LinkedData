#!/bin/sh
# Crear contenedor básico para el usuario Pablo
curl -s http://localhost:8080 -XPOST -H"Slug: pablo" -H"Link: <http://www.w3.org/ns/ldp#BasicContainer>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/pablo.ttl

#Crear recurso  RDF con la informacion del usuario 
curl -s http://localhost:8080/pablo/ -XPOST -H"Slug: informacion" -H"Link: <http://www.w3.org/ns/ldp#Resource>; rel=\"type\"" -H"Content-Type: text/turtle" --data-binary @recursos/informacion.ttl

#Crear un recurso no RDF de tipo imagen para el usuario
curl -s http://localhost:8080/pablo/ -XPOST -H"Slug: avatar" -H"Link: <http://www.w3.org/ns/ldp#Resource>; rel=\"type\"" -H"Content-Type: image/jpg" --data-binary @recursos/avatar.jpg