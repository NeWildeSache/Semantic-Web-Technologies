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
 	:hatMusicBrainzArtistId ?ID .
 ?genre a :Genre ; 
    :hatName ?genreLabel.
}
WHERE {
  ?knownDarbieter rdf:type :Musikdarbieter .
  ?knownDarbieter :hatName ?name .
  ?knownDarbieter :kommtAus ?land .
  ?land :hatName ?landLabel .
  SERVICE <https://query.wikidata.org/sparql> {
	SELECT DISTINCT ?name ?ID ?landLabel ?genreLabel 
    WHERE {
      SERVICE wikibase:label {
        bd:serviceParam wikibase:language "de".
      } 
      ?darbieter rdfs:label ?name .
      ?darbieter wdt:P434 ?ID .
      ?darbieter wdt:P136 ?genre .
      OPTIONAL{?darbieter wdt:P495 ?origin .}
      OPTIONAL{?darbieter wdt:P27 ?citizenship .}
      ?citizenship rdfs:label ?landLabel .
      ?origin rdfs:label ?landLabel .
      FILTER(?origin = ?citizenship)
      FILTER (?darbieter != wd:Q1403672 )
    }
  }
} 