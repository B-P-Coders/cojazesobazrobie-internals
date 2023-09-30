#!/bin/bash
pg_dump --inserts -U postgres -h localhost cojazesobazrobie > db.sql
