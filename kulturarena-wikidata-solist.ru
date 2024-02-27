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
    :hatGeschlecht ?geschlechtLabel ;
    :hatGeburtsdatum ?geburtsdatum ;
    :hatMitglied ?mitglied .
?knownDarbieter a :Musiker .
?genre a :Genre ; 
    :hatName ?genreLabel . 
?land :hatEinwohneranzahl ?bevoelkerung .
}
WHERE {
  ?knownDarbieter rdf:type :Musikdarbieter .
  ?knownDarbieter :hatName ?name .
  ?knownDarbieter :kommtAus ?land .
  ?land rdf:type :Land .
  ?land :hatName ?landLabel .
  
  SERVICE <https://query.wikidata.org/sparql> {
    SELECT DISTINCT ?name ?ID ?genre ?genreLabel ?geschlechtLabel ?geburtsdatum ?landLabel ?bevoelkerung
    WHERE {
        ?darbieter rdfs:label ?name .
        ?darbieter wdt:P434 ?ID .
        ?darbieter wdt:P136 ?genre .
        OPTIONAL{?darbieter wdt:P27 ?citizenship .
                ?citizenship wdt:P1082 ?bevoelkerung . }
        ?citizenship rdfs:label ?landLabel .          
        OPTIONAL{?darbieter wdt:P21 ?geschlecht }
        OPTIONAL{?darbieter wdt:P569 ?geburtsdatum . }

        ?darbieter wdt:P31 ?type .
        FILTER (?type = wd:Q5) .
        FILTER (?darbieter != wd:Q1403672 ) .

        SERVICE wikibase:label {
        bd:serviceParam wikibase:language "de".
        ?genre rdfs:label ?genreLabel .
        ?geschlecht rdfs:label ?geschlechtLabel .
        }
      
  }
} 
}

