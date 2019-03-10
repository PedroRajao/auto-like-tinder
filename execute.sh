#!/bin/bash
# Adicionar um crontab para esse script rodar todo dia às 2:25

# Inicia chromedriver
./vendor/bin/chromedriver --url-base=/wd/hub &

# Executa codecept auto_like 5 vezes
for i in {1..5}
do
   ./vendor/bin/codecept run --steps
done

# Suspende pc até 5 minutos antes do horário que esse script rodou do dia seguinte
./suspend_until.sh 02:20
