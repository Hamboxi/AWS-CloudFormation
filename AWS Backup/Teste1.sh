#!/usr/bin/env bash

stackName="myteststack3"
nameVault="PROD01"
namePlan="EC2-PROD" #Nome do plano de Backup
frequencyBackup="DIARIO" #HORARIO ou DIARIO
retencao="30"
newVault="Nao" #Confirmar necessidade de novo Vault (Sim, Nao)

case $frequencyBackup in
    DIARIO)
        freqBackup=('?' '*' '0' '0' '*' '*') #(Dia, Dia da semana, Hora, Minuto, Mes, Ano)
        ;;
    HORARIO)
        freqBackup=('?' '*' '*' '0' '*' '*')
        ;;
esac

aws cloudformation create-stack --stack-name $stackName --template-body file://BackupPlan.YAML \
    --parameters \
    ParameterKey=VaultName,ParameterValue=$nameVault \
    ParameterKey=NewVaultName,ParameterValue=$newVault \
    ParameterKey=BackupPlanName,ParameterValue=$namePlan \
    ParameterKey=CronDay,ParameterValue="${freqBackup[0]}" \
    ParameterKey=CronDayOfWeek,ParameterValue="${freqBackup[1]}" \
    ParameterKey=CronHour,ParameterValue="${freqBackup[2]}" \
    ParameterKey=CronMinute,ParameterValue="${freqBackup[3]}" \
    ParameterKey=CronMonth,ParameterValue="${freqBackup[4]}" \
    ParameterKey=CronYear,ParameterValue="${freqBackup[5]}" \
    ParameterKey=DiaRetencao,ParameterValue=$nameVault