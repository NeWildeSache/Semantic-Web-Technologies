PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX http: <http://www.w3.org/2011/http#>
PREFIX : <http://example.org/kulturarena/>
PREFIX bd:       <http://www.bigdata.com/rdf#>
PREFIX wd:       <http://www.wikidata.org/entity/>
PREFIX wdt:      <http://www.wikidata.org/prop/direct/>
PREFIX wikibase: <http://wikiba.se/ontology#>
PREFIX fun: <http://w3id.org/sparql-generate/fn/>


INSERT {
?knownDarbieter :hatGenre ?genreIRI ;
    :hatMusicBrainzArtistId ?ID ;
    :hatMitglied ?mitgliedIRI .
?genreIRI a :Genre ; 
    :hatName ?genreLabel.
?land :hatEinwohneranzahl ?bevoelkerung .
?mitgliedIRI a :Musiker ;
    :hatName ?mitgliedName ;
    :hatGeschlecht ?mitgliedGeschlechtLabel ;
    :hatGeburtsdatum ?geburtsdatum ;
    :kommtAus ?mitgliedLandIRI .
?mitgliedLandIRI a :Land ;
    :hatName ?mitgliedLandLabel ;
    :hatEinwohneranzahl ?mitgliedLandBevoelkerung .
}
WHERE {
  ?knownDarbieter rdf:type :Musikdarbieter .
  ?knownDarbieter :hatName ?name .
  ?knownDarbieter :kommtAus ?land .
  ?land rdf:type :Land .
  ?land :hatName ?landLabel .
  
  SERVICE <https://query.wikidata.org/sparql> {
    SELECT DISTINCT ?name ?ID ?genre ?genreLabel ?landLabel ?bevoelkerung ?mitglied ?mitgliedName ?mitgliedGeschlechtLabel ?mitgliedGeburtsdatum ?mitgliedLand ?mitgliedLandLabel ?mitgliedLandBevoelkerung
    WHERE {
      ?darbieter rdfs:label ?name .
      ?darbieter wdt:P495 ?origin .
      ?origin rdfs:label ?landLabel .
      OPTIONAL{?origin wdt:P1082 ?bevoelkerung .}
      OPTIONAL{?darbieter wdt:P434 ?ID .}
      OPTIONAL{?darbieter wdt:P136 ?genre .}

      OPTIONAL{?darbieter wdt:P527 ?mitglied .
              OPTIONAL{?mitglied wdt:P21 ?mitgliedGeschlecht . }
              OPTIONAL{?mitglied wdt:P569 ?mitgliedGeburtsdatum . }
              OPTIONAL{?mitglied wdt:P27 ?mitgliedLand . 
          				    OPTIONAL{?mitgliedLand wdt:P1082 ?mitgliedLandBevoelkerung}}
              }

      ?darbieter wdt:P31 ?type .
      FILTER (?type != wd:Q5) .
      FILTER (?darbieter != wd:Q1403672 ) .

      SERVICE wikibase:label {
        bd:serviceParam wikibase:language "de".
        ?mitgliedLand rdfs:label ?mitgliedLandLabel .
        ?mitgliedGeschlecht rdfs:label ?mitgliedGeschlechtLabel .
        ?mitglied rdfs:label ?mitgliedName .
        ?genre rdfs:label ?genreLabel .
      }
    } 
  } 
  BIND(IRI(CONCAT("http://example.org/kulturarena/",REPLACE(?genreLabel," ",""))) AS ?genreIRI) .
  BIND(IRI(CONCAT("http://example.org/kulturarena/",REPLACE(?mitgliedName," ",""))) AS ?mitgliedIRI) .
  BIND(IRI(CONCAT("http://example.org/kulturarena/",REPLACE(?mitgliedLandLabel," ",""))) AS ?mitgliedLandIRI) .
}

