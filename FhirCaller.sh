#!/bin/bash

#Tutoriales: https://fhir-drills.github.io/simple-patient.html
#Paciente pruebas: https://stu3.test.pyrohealth.net/fhir/Patient/0ff5eb19-a083-4271-9c07-39631f03be95

#echo "Inicio"

#Constantes

APP_HOME_FOLDER=`pwd`
APP_LOG_FOLDER=${APP_HOME_FOLDER}/log/
APP_FUNCTIONS_FILE="${APP_HOME_FOLDER}/include/functions.sh"

#Funciones....
#Cargo las funciones del fichero de "include"
if [[ -f ${APP_FUNCTIONS_FILE} ]]; then
    . ${APP_FUNCTIONS_FILE}
else
    echo "ERROR al cargar el fichero de funciones."
    exit 1
fi

#Programa....

#Primero check del numero de parámetros.
if [[ $# -lt 2 ]]
then
    usage
fi


#Parseamos el array de parámetros de entrada
POSITIONAL=()

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
    #Config del curl
        -c|--config)
        #Para pasarle la opción -K o --config <file> a curl
            PARAM_CFG_FILE=$2
            shift
            shift
        ;;
    #Modo verbose
        -v|--verbose)
            PARAM_VERBOSE=true
            shift # past argument
            #shift # past value
            #Como se supone que va SIN argumentos,  hago solo un shift
        ;;
    #Fichero de log (automatico)
         #-l|--log)
         -l)
            PARAM_LOG=true
          #  shift
            shift
        ;;
        #Fichero de log especificando fichero
        --log)
            PARAM_LOG=true
            PARAM_FILE_LOG=$2
            shift
            shift
        ;;
    #Ayuda
        -h|--help)
            usage
            exit 0
        ;;
    #others....
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            PARAM_URL=$1
            shift # past argument
        ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

#El ultimo parámetro SIEMPRE será la URL.
#PARAM_URL="${!#}"
#PARAM_URL="${POSITIONAL[$#-1]}"

checkParams

initLog

#echo "URL: $PARAM_URL\n" 

verbose "URL: ${PARAM_URL} \n"


#PARAM_CFG_FILE=$1
#PARAM_URL=$2

#curl -i -H "Accept: $RESP_ACCEPT" -H "Content-type: $REQ_CONTENT" $3

#curl -K $PARAM_CFG_FILE $PARAM_URL


#echo "Final"