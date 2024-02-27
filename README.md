# How to use this repository

### Important Files

##### Data files:

*kulturarena-ontology.ttl*: original ontology with a few sample instances
*generated-data.ttl*: instances derived from kulturarena website
*kulturarena-data.ttl*: kulturarena-ontology.ttl + generated-data.ttl + data derived from wikidata
*kulturarena-inferred.ttl*: kulturarena-data.tll + information inferred by reasoner

##### Scripts:

*get-data.sh*: solves task 3
*reason.sh*: solves task 4
*get-data-and-reason.sh*: solves task 3 and 4
