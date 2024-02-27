#!/bin/sh
echo "Getting data from Kulturarena website"
java -jar sparql-generate-2.1.0.jar -q kulturarena-website-konzerte.rqg -o generated-data.ttl -fo TTL -l DEBUG

echo ""
echo "Getting data from Wikidata for ensembles and members"
./robot -vvv \
    merge --input kulturarena-ontology.ttl \
          --input generated-data.ttl \
    query --update kulturarena-wikidata-ensembles-mitglied.ru \
          --output kulturarena-data.ttl

echo ""
echo "Getting data from Wikidata for solists"
./robot -vvv \
    merge --input kulturarena-data.ttl \
    query --update kulturarena-wikidata-solist.ru \
          --output kulturarena-data.ttl