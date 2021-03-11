#!/bin/bash

#Funciones....
function usage {

    echo -e "Use of script: $0 --config <config file> <url>"
    exit 1
}

function verbose {

    if [[ ${PARAM_VERBOSE} ]]
    then
        echo -e $1
    fi

    if [[ ${PARAM_LOG} ]]
    then
        echo $1 >> ${PARAM_LOG}
    fi

}

function initLog {

    if [[ ${PARAM_LOG} ]]
    then
        if [[ -z "${PARAM_FILE_LOG}" ]]
        then
            PARAM_FILE_LOG=${APP_LOG_FOLDER}$(timestamp).log
        fi
        echo -e "Log" >> ${PARAM_FILE_LOG}
    fi

}

# Define a timestamp function
function timestamp {
#  date +"%T"
    local stamp=`date +"%Y-%m-%d_%H-%M-%S"`
    #return "$stamp"
    echo "$stamp"
}

function printERROR {

    if [[ ${PARAM_LOG} ]]
    then
        echo -e "\t***ERROR: $1" >> ${PARAM_FILE_LOG}
    fi

    if [[ ${PARAM_VERBOSE} ]]
    then
        echo -e "\t***ERROR: $1"
    fi

    
}

function printWARNING {

    if [[ ${PARAM_LOG} ]]
    then
        echo -e "\t***WARNING: $1" >> ${PARAM_FILE_LOG}
    fi

    if [[ ${PARAM_VERBOSE} ]]
    then
        echo -e "\t***WARNING: $1"
    fi
    
}

function printINFOS {

    if [[ ${PARAM_LOG} ]]
    then
        echo -e "\tINFO: $1" >> ${PARAM_FILE_LOG}
    fi

    if [[ ${PARAM_VERBOSE} ]]
    then
        echo -e "\tINFO: $1"
    fi
 

    
}

function checkParams {
    
    if [[ -z "${PARAM_CFG_FILE}" || -z "${PARAM_URL}" ]]
    then
        echo "URL: ${PARAM_URL} CFG: ${PARAM_CFG_FILE}"
        echo -e "ERROR: faltan parámetros obligatorios"
        usage
        exit 1

    fi

}