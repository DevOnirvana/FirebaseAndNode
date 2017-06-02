# Introduction

Store commit SHA1 Hash and Messages in MongoDB every time a commit is pushed to github.com

## Architecture

1. Every time a commit is pushed to github.com, the post-commit script executes.
2. This script is present in .git/hooks of the parent directory and is written in python.(It has been provided along with the code) as well as here for convenience.
	```
		#!/usr/local/bin/python

		import time
		from datetime import datetime

		import logging
		import subprocess as sp

		from pymongo import MongoClient

		log = logging.getLogger(__name__)

		client = MongoClient('db.mongodb.priceboard.in:27017')
		log.info('Database Connected')
		db = client.assignment

		output = sp.check_output(['git log -1 --format="%H,%s"'],shell=True).decode(encoding='ascii')
		sha,msg = output.split(',')
		post = {"sha1":sha, "commit_msg":msg, "time":datetime.utcnow()}
		db.assignment.insert_one(post)
		log.info('Data successfully saved to database')
	```
3. This script then parses the commit message and the SHA 1 hash and saves it in MongoDB along with the currect date-time in the form given below.
	```
	{ "_id" : ObjectId("5931b05c59b50f00098b6cae"), 
	"sha1" : "9b939587e1bd2432ac09db2e8b6d6023993d65dc", 
	"commit_msg" : "success message stored\n", 
	"time" : ISODate("2017-06-02T18:37:16.723Z") 
	}
	```

### Deployment
`sudo docker-compose up --build`

### Prerequisites

```
1. Docker
2. docker-compose
```
