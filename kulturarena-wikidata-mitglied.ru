PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX http: <http://www.w3.org/2011/http#>
PREFIX : <http://example.org/kulturarena/>
PREFIX bd:       <http://www.bigdata.com/rdf#>
PREFIX wd:       <http://www.wikidata.org/entity/>
PREFIX wdt:      <http://www.wikidata.org/prop/direct/>
PREFIX wikibase: <http://wikiba.se/ontology#>


INSERT {
?knownDarbieter :hatGenre ?genre ;
    :hatMusicBrainzArtistId ?ID ;
    :wikidataType ?type ;
    :hatGeschlecht ?geschlechtLabel ;
    :hatGeburtsdatum ?geburtsdatum ;
    :hatMitglied ?mitglied .
?genre a :Genre ; 
    :hatName ?genreLabel.
?land :hatEinwohneranzahl ?bevoelkerung .
?mitglied a :Musiker ;
    :hatName ?mitgliedName ;
    :hatGeschlecht ?mitgliedGeschlechtLabel ;
    :hatGeburtsdatum ?geburtsdatum ;
    :kommtAus ?mitgliedLand .
?mitgliedLand a :Land ;
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
    SELECT DISTINCT ?name ?ID ?genre ?genreLabel ?geschlechtLabel ?geburtsdatum ?mitglied ?mitgliedName ?mitgliedGeschlechtLabel ?mitgliedGeburtsdatum ?mitgliedLand ?mitgliedLandLabel ?mitgliedLandBevoelkerung ?landLabel ?bevoelkerung ?type
    WHERE {
      ?darbieter rdfs:label ?name .
      ?darbieter wdt:P434 ?ID .
      ?darbieter wdt:P136 ?genre .
      OPTIONAL{?darbieter wdt:P27 ?citizenship .
                ?citizenship wdt:P1082 ?bevoelkerung .}
      OPTIONAL{?darbieter wdt:P495 ?origin .
            ?origin wdt:P1082 ?bevoelkerung .}
      ?citizenship rdfs:label ?landLabel .
      ?origin rdfs:label ?landLabel .
      FILTER (?darbieter != wd:Q1403672 )
      OPTIONAL{?darbieter wdt:P21 ?geschlecht }
      OPTIONAL{?darbieter wdt:P569 ?geburtsdatum . }
      OPTIONAL{?darbieter wdt:P527 ?mitglied .
              OPTIONAL{?mitglied wdt:P21 ?mitgliedGeschlecht . }
              OPTIONAL{?mitglied wdt:P569 ?mitgliedGeburtsdatum . }
              OPTIONAL{?mitglied wdt:P27 ?mitgliedLand . 
          				    OPTIONAL{?mitgliedLand wdt:P1082 ?mitgliedLandBevoelkerung}}
              }
      ?darbieter wdt:P31 ?type .

      SERVICE wikibase:label {
        bd:serviceParam wikibase:language "de".
        ?mitgliedLand rdfs:label ?mitgliedLandLabel .
        ?mitgliedGeschlecht rdfs:label ?mitgliedGeschlechtLabel .
        ?genre rdfs:label ?genreLabel .
        ?geschlecht rdfs:label ?geschlechtLabel .
        ?mitglied rdfs:label ?mitgliedName .
      }
      
  }
} 
}

