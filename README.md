# How to use this repository

I changed a couple of things about the workflow to make it easier for me:
- I created shell scripts that contain my workflow so you just have to run the script for task 3 and 4.
- I created an extra file called *generated-data.ttl* for the information derived from the kulturarena website.
- I did the wikidata queries in a different order: queries for solists are in the file *kulturarena-wikidata-solist.ru* and queries for ensembles and their mitglied are in the file *kulturarena-wikidata-ensembles-mitglied.ru*.
- I did not create an extra file called *ontology-extension.ttl* and just input those extra definitions into the original *kulturarena-ontology.ttl* file.

#### Important Files

##### Data files:

*kulturarena-ontology.ttl*: original ontology with a few sample instances \
*generated-data.ttl*: instances derived from kulturarena website \
*kulturarena-data.ttl*: kulturarena-ontology.ttl + generated-data.ttl + data derived from wikidata \
*kulturarena-inferred.ttl*: kulturarena-data.tll + information inferred by reasoner \

##### Scripts:

*get-data.sh*: solves task 3 \
*reason.sh*: solves task 4 \
*get-data-and-reason.sh*: solves task 3 and 4 \
