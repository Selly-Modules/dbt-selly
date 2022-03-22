#!bin/bash

push:
	git add . && git commit -a -m "update" && git push

run:
	dbt deps --profiles-dir=. --project-dir=.
    #dbt run --profiles-dir=. --project-dir=. --full-refresh
	dbt run --profiles-dir=. --project-dir=. --full-refresh --select orders

