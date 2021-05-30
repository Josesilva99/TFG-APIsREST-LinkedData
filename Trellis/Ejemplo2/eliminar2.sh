#!/bin/sh
curl -X DELETE http://localhost:8080/editorial/publicacion1/libro1
curl -X DELETE http://localhost:8080/editorial/publicacion1/
curl -X DELETE http://localhost:8080/editorial/escritores/
curl -X DELETE http://localhost:8080/editorial/

