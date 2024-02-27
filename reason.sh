#!/bin/sh
echo "Inferring"
./robot -vvv \
      merge --input kulturarena-data.ttl \
      reason --reasoner hermit \
      --axiom-generators "SubClass EquivalentClass DisjointClasses ClassAssertion" \
      --output kulturarena-inferred.ttl

echo ""
echo "Exporting every Solist into csv"
./robot -vvv \
      query --input kulturarena-inferred.ttl \
            --query kulturarena-solist.rq kulturarena-solist.csv

echo ""
echo "Exporting every Musikensemble into csv"
./robot -vvv \
      query --input kulturarena-inferred.ttl \
            --query kulturarena-ensemble.rq kulturarena-ensemble.csv

echo ""
echo "Exporting every internationalesKonzert into csv"
./robot -vvv \
      query --input kulturarena-inferred.ttl \
            --query kulturarena-internationales-konzert.rq kulturarena-internationales-konzert.csv