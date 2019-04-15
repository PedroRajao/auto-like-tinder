#!/bin/bash
# Start a crontab to execute this script everyday at HH:MM


# Start chromedriver
./vendor/bin/chromedriver --url-base=/wd/hub &

# Execute codecept auto_like N times
for i in {1..5}
do
   ./vendor/bin/codecept run --steps
done

# Suspends PC until next day = 24 hours minus 5 minutes
#./suspend_until.sh HH:MM (-5)
