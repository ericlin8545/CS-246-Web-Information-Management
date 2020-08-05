#!/bin/bash

# Uncomment the following two commands to compile and execute your modified ParseJSON code in this script.

javac ParseJSON.java
java ParseJSON

# TASK 2A:
# Create and index the documents using the default standard analyzer
curl -H "Content-Type: application/json" -XPOST "localhost:9200/task2a/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"




# TASK 2B:
# Create and index with a whitespace analyzer
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/task2b?pretty' -d '
{
	"mappings": {
		"wikipage" : {
			"_all": {"type": "text", "analyzer" : "whitespace"},
			"properties" : {
				"title" : {
					"type" : "text",
					"analyzer" : "whitespace"
				},
				"abstract" : {
					"type" : "text",
					"analyzer" : "whitespace"
				},
				"url" : {
					"type" : "text",
					"analyzer" : "whitespace"
				},
				"sections" : {
					"type" : "text",
					"analyzer" : "whitespace"
				}
			}
		}
	}
}
'


curl -H "Content-Type: application/json" -XPOST "localhost:9200/task2b/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"


# TASK 2C:
# Create and index with a custom analyzer as specified in Task 2C
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/task2c?pretty' -d '
{	
	"settings": {
        "analysis": {
            "filter": {
                "my_stopwords": {
                    "type":       "stop",
                    "stopwords": "_english_"
            	},
            	"my_snow" : {
                    "type" : "snowball",
                    "language" : "English"
                }
        	},
            "analyzer": {
                "my_analyzer": {
                    "type" :         "custom",
                    "char_filter" :  "html_strip",
                    "tokenizer" :    "standard",
                    "filter" :       [ "asciifolding", "lowercase", "my_stopwords", "my_snow" ]
            	}
        	}
        }
	}
}
'

curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/task2c/_mappings/wikipage?pretty' -d '
{
	"_all": {"type": "text", "analyzer" : "my_analyzer"},
	"properties" : {
		"title" : {
			"type" : "text",
			"analyzer" : "my_analyzer"
		},
		"abstract" : {
			"type" : "text",
			"analyzer" : "my_analyzer"
		},
		"url" : {
			"type" : "text",
			"analyzer" : "my_analyzer"
		},
		"sections" : {
			"type" : "text",
			"analyzer" : "whitespace"
		}
	}
}
'

curl -H "Content-Type: application/json" -XPOST "localhost:9200/task2c/wikipage/_bulk?pretty&refresh" --data-binary "@data/out.txt"

