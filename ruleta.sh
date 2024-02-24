#!/bin/bash
# Author: Shevanio

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function ctrl_c(){
  echo -e "\n\n${redColour}[!] Saliendo...\n${endcolour}"
  tput cnorm
  exit 1
}

# Ctrl + C
trap ctrl_c INT



function martingala(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero actual: ${endColour}${yellowColour} $money€${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour} Stake inicial -> ${endColour}" && read bet
  echo -ne "${yellowColour}[+]${endColour}${grayColour} Suerte sencilla (par/impar) -> ${endColour}" && read par_impar
  if [[ "$par_impar" == "par" || "$par_impar" == "impar" ]]; then
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Vamos a jugar con una cantidad inicial de ${endColour}${yellowColour}$bet€ ${endColour}${grayColour}a ${endColour}${yellowColour}$par_impar${endColour}${grayColour}.${endColour}"
    #echo -e "\n${yellowColour}[+]${endColour}${grayColour} Vamos a jugar con la técnica:${endColour}${purpleColour} Martingala.${endColour}\n"

    backup_bet=$bet
    tput civis # Ocultar cursor
    ronda=0
    perdidas=""
    ganadas=""
    total_ganadas=""
    total_perdidas=""
    perdidas_seguidas="[ "
    while true; do
      money=$(($money - $bet))
      random_number="$((RANDOM % 37))"
      let ronda+=1
      if [ ! "$money" -lt 0 ]; then
        if [ "$par_impar" == "par" ]; then
          echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar: ${endColour}${purpleColour}$bet€${endColour} a par y te quedan: ${purpleColour}$money€${endColour}${grayColour}.${endColour}"
          echo -e "${yellowColour}[-]${endColour}${grayColour} En la ronda: ${endColour}${turquoiseColour}$ronda ${endColour}${grayColour} ha salido el número: ${endColour}${turquoiseColour}$random_number${endColour}${grayColour}.${endColour}"
          if [ "$(($random_number % 2))" -eq 0 ]; then
            if [ "$random_number" -eq 0 ]; then
              echo -e "${yellowColour}[-]${endColour} El número que ha salido es el 0, ${redColour}¡Pierdes!${endColour}"
              echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
              echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
              bet=$(($bet*2))
              perdidas_seguidas+="$random_number "
              let total_perdidas+=1
            else
              echo -e "${yellowColour}[-]${endColour} El número que ha salido es par, ${greenColour}¡Ganas!${endColour}"
              reward=$(($bet*2))
              echo -e "${yellowColour}[-]${endColour} Ganas: $reward€."
              money=$(($money+$reward))
              echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
              bet=$backup_bet
              perdidas_seguidas="[ "
              let total_ganadas+=1
            fi
          else
            echo -e "${yellowColour}[-]${endColour} El número que ha salido es impar, ${redColour}¡Pierdes!${endColour}"
            echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
            echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
            bet=$(($bet*2))
            perdidas_seguidas+="$random_number "
            let total_perdidas+=1
          fi
        elif [ "$par_impar" == "impar" ]; then
          echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar: ${endColour}${purpleColour}$bet€${endColour} a impar y te quedan: ${purpleColour}$money€${endColour}${grayColour}.${endColour}"
          echo -e "${yellowColour}[-]${endColour}${grayColour} En la ronda: ${endColour}${turquoiseColour}$ronda ${endColour}${grayColour} ha salido el número: ${endColour}${turquoiseColour}$random_number${endColour}${grayColour}.${endColour}"
          if [ "$(($random_number % 2))" -eq 1 ]; then
            if [ "$random_number" -eq 0 ]; then
              echo -e "${yellowColour}[-]${endColour} El número que ha salido es el 0, ${redColour}¡Pierdes!${endColour}"
              echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
              echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
              bet=$(($bet*2))
              perdidas_seguidas+="$random_number "
              let total_perdidas+=1
            else
              echo -e "${yellowColour}[-]${endColour} El número que ha salido es impar, ${greenColour}¡Ganas!${endColour}"
              reward=$(($bet*2))
              echo -e "${yellowColour}[-]${endColour} Ganas: $reward€."
              money=$(($money+$reward))
              echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
              bet=$backup_bet
              perdidas_seguidas="[ "
              let total_ganadas+=1
            fi
          else
            echo -e "${yellowColour}[-]${endColour} El número que ha salido es par, ${redColour}¡Pierdes!${endColour}"
            echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
            echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
            bet=$(($bet*2))
            perdidas_seguidas+="$random_number "
            let total_perdidas+=1
          fi
        fi
      else
        echo -e "${yellowColour}[!]${endColour} ${redColour}¡Te has quedado a $money!${endColour}\n"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Has perdido en la ronda $(($ronda-1))${endColour}${grayColour} con una racha de ${redColour}$(echo $perdidas_seguidas|wc -w)${endColour}${grayColour}.${endColour}"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Últimos números: ${endColour}${turquoiseColour}$perdidas_seguidas]${endColour}${grayColour}.${endColour}\n"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Total Perdidas: ${endColour}${redColour}$total_perdidas${endColour}${grayColour}.${endColour}"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Total Ganadas: ${endColour}${greenColour}$total_ganadas${endColour}${grayColour}.${endColour}\n"
        tput cnorm; exit 0
      fi
    done
  else
  echo -e "${yellowColour}[!]${endColour} ${redColour}¡Introduce una suerte sencilla correcta!${endColour}\n"
  exit 1
  fi
    
  

tput cnorm # Recuperar cursor
}

function inverseLabrouchere(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero actual: ${endColour}${yellowColour} $money€${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour} Suerte sencilla (par/impar) -> ${endColour}" && read par_impar

  declare -a sequence=(1 2 3 4)

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Comenzamos con la secuencia: ${endColour}${yellowColour}[${sequence[@]}]${endColour}"

  bet=$((${sequence[0]} + ${sequence[-1]}))

  sequence=(${sequence[@]})
 
  tput civis # Ocultar cursor
  ronda=0
  perdidas=""
  ganadas=""
  total_ganadas=""
  total_perdidas=""
  perdidas_seguidas="[ "
  bet_to_renew=$(($money+50))
  echo -e "\n${yellowColour}[+]${endcolour}${grayColour} El tope a renovar la secuencia está establecido en por encima de los ${endColour}${yellowColour}$bet_to_renew€${endColour}"
  
  while true; do
    money=$(($money - $bet))
    random_number=$(($RANDOM % 37))
    let ronda+=1
    #echo -e "${yellowColour}[-]${endColour}${grayColour} En la ronda: ${endColour}${turquoiseColour}$ronda ${endColour}${grayColour} ha salido el número: ${endColour}${turquoiseColour}$random_number${endColour}${grayColour}.${endColour}"
    sleep 3
    if [ ! "$money" -lt 0 ]; then
      if [ "$par_impar" == "par"  ]; then
        echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar: ${endColour}${purpleColour}$bet€${endColour} a par y te quedan: ${purpleColour}$money€${endColour}${grayColour}.${endColour}"
        echo -e "${yellowColour}[-]${endColour}${grayColour} En la ronda: ${endColour}${turquoiseColour}$ronda ${endColour}${grayColour} ha salido el número: ${endColour}${turquoiseColour}$random_number${endColour}${grayColour}.${endColour}"
        if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
          echo -e "${yellowColour}[-]${endColour} El número que ha salido es par, ${greenColour}¡Ganas!${endColour}"
          reward=$(($bet*2))
          echo -e "${yellowColour}[-]${endColour} Ganas: $reward€."
          let money+=$reward
          echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
          perdidas_seguidas="[ "
          let total_ganadas+=1

          if [ $money -gt $bet_to_renew ]; then
            echo -e "\n${yellowColour}[+]${endcolour}${grayColour} Se ha superado el tope establecido ${endColour}${greenColour}$bet_to_renew${endColour}${grayColour} para renovar nuestra secuencia${endColour}"
            bet_to_renew=$(($bet_to_renew+50))
            echo -e "${yellowColour}[-]${endcolour}${grayColour} El tope se ha establecido ${endColour}${greenColour}$bet_to_renew${endColour}"
            sequence=(1 2 3 4)
            bet=$((${sequence[0]} + ${sequence[-1]}))
            echo -e "${yellowColour}[-]${endcolour}${grayColour} Restablecemos la secuencia a: ${endColour}${greenColour}[$sequence]${endColour}"
          else
            sequence+=($bet)
            sequence=(${sequence[@]})

            echo -e "${yellowColour}[-]${endColour}${grayColour} Nueva secuencia: ${endColour}${greenColour}[${sequence[@]}]${endColour}"
            if [ "${#sequence[@]}" -ne 1 ] && [ "${#sequence[@]}" -ne 0 ]; then
              bet=$((${sequence[0]} + ${sequence[-1]}))
            elif [ "${#sequence[@]}" -eq 1 ]; then
              bet=${sequence[@]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              sequence=(1 2 3 4)
              echo -e "${yellowColour}[-]${endColour}${grayColour} Restablecemos la secuencia a: ${endColour}${greenColour}[${sequence[@]}]${endColour} "
              bet=$((${sequence[0]} + ${sequence[-1]}))
            fi

          fi
        elif [ "$(($random_number % 2))" -eq 1 ] || [ "$random_number" -eq 0  ]; then
          if [ "$(($random_number % 2))" -eq 1 ]; then
            echo -e "${yellowColour}[-]${endColour} El número que ha salido es impar, ${redColour}¡Pierdes!${endColour}"
            echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
            echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
            perdidas_seguidas+="$random_number "
            let total_perdidas+=1
          else
            echo -e "${yellowColour}[-]${endColour} El número que ha salido es el 0, ${redColour}¡Pierdes!${endColour}"
            echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
            echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
            perdidas_seguidas+="$random_number "
            let total_perdidas+=1
          fi
          if [ $money -lt $(($bet_to_renew-100)) ]; then 
            echo -e "\n${yellowColour}[!]${endcolour}${grayColour} Hemos llegado a un mínimo crítico, se procede a reajustar el tope${endColour}"
            bet_to_renew=$(($bet_to_renew - 100))
            echo -e "${yellowColour}[-]${endcolour}${grayColour} El tope ha sido renovado a: ${endColour}${yellowColour}$bet_to_renew€${endColour}"

            unset sequence[0]
            unset sequence[-1] 2>/dev/null

            sequence=(${sequence[@]})

            echo -e "${yellowColour}[-]${endColour}${grayColour} Nueva secuencia: ${endColour}${greenColour}[${sequence[@]}]${endColour}"
            if [ "${#sequence[@]}" -ne 1 ] && [ "${#sequence[@]}" -ne 0 ]; then
              bet=$((${sequence[0]} + ${sequence[-1]}))
            elif [ "${#sequence[@]}" -eq 1 ]; then
              bet=${sequence[@]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              sequence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a: ${endColour}${greenColour}[${sequence[@]}]${endColour} "
              bet=$((${sequence[0]} + ${sequence[-1]}))
            fi
          else
            unset sequence[0]
            unset sequence[-1] 2>/dev/null

            sequence=(${sequence[@]})

            echo -e "${yellowColour}[-]${endColour}${grayColour} Nueva secuencia: ${endColour}${greenColour}[${sequence[@]}]${endColour}"
            if [ "${#sequence[@]}" -ne 1 ] && [ "${#sequence[@]}" -ne 0 ]; then
              bet=$((${sequence[0]} + ${sequence[-1]}))
            elif [ "${#sequence[@]}" -eq 1 ]; then
              bet=${sequence[@]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              sequence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a ${endColour}${greenColour}[${sequence[@]}]${endColour} "
              bet=$((${sequence[0]} + ${sequence[-1]}))
            fi
          fi
        fi

      elif [ "$par_impar" == "impar"  ]; then
        echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar: ${endColour}${purpleColour}$bet€${endColour} a par y te quedan: ${purpleColour}$money€${endColour}${grayColour}.${endColour}"
        echo -e "${yellowColour}[-]${endColour}${grayColour} En la ronda: ${endColour}${turquoiseColour}$ronda ${endColour}${grayColour} ha salido el número: ${endColour}${turquoiseColour}$random_number${endColour}${grayColour}.${endColour}"
        if [ "$(($random_number % 2))" -eq 1 ] && [ "$random_number" -ne 0 ]; then
          echo -e "${yellowColour}[-]${endColour}${grayColour} El número que ha salido es impar, ${endColour}${greenColour}¡Ganas!${endColour}"
          reward=$(($bet*2))
          echo -e "${yellowColour}[-]${endColour} Ganas: $reward€."
          let money+=$reward
          echo -e "${yellowColour}[-]${endColour}${grayColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
          perdidas_seguidas="[ "
          let total_ganadas+=1

          if [ $money -gt $bet_to_renew ]; then
            echo -e "\n${yellowColour}[+]${endcolour}${grayColour} Se ha superado el tope establecido ${endColour}${greenColour}$bet_to_renew${endColour}${grayColour} para renovar nuestra secuencia${endColour}"
            bet_to_renew=$(($bet_to_renew+50))
            echo -e "${yellowColour}[-]${endcolour}${grayColour} El tope se ha establecido ${endColour}${greenColour}$bet_to_renew${endColour}"
            sequence=(1 2 3 4)
            bet=$((${sequence[0]} + ${sequence[-1]}))
            echo -e "${yellowColour}[-]${endcolour}${grayColour} La secuencia ha sido restablecida a: ${endColour}${greenColour}[$sequence]${endColour}"
          else
            sequence+=($bet)
            sequence=(${sequence[@]})

            echo -e "${yellowColour}[-]${endColour}${grayColour} Nueva secuencia: ${endColour}${greenColour}[${sequence[@]}]${endColour}"
            if [ "${#sequence[@]}" -ne 1 ] && [ "${#sequence[@]}" -ne 0 ]; then
              bet=$((${sequence[0]} + ${sequence[-1]}))
            elif [ "${#sequence[@]}" -eq 1 ]; then
              bet=${sequence[@]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              sequence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a: ${endColour}${greenColour}[${sequence[@]}]${endColour} "
              bet=$((${sequence[0]} + ${sequence[-1]}))
            fi

          fi

        elif [ "$(($random_number % 2))" -eq 0 ] || [ "$random_number" -eq 0 ]; then
          if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
            echo -e "${yellowColour}[-]${endColour} El número que ha salido es par, ${redColour}¡Pierdes!${endColour}"
            echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
            echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
            perdidas_seguidas+="$random_number "
            let total_perdidas+=1
          else
            echo -e "${yellowColour}[-]${endColour} El número que ha salido es el 0, ${redColour}¡Pierdes!${endColour}"
            echo -e "${yellowColour}[-]${endColour} Pierdes: ${endColour}${purpleColour}$bet€${endColour}."
            echo -e "${yellowColour}[-]${endColour} Tienes: ${endColour}${purpleColour}$money€${endColour}."
            perdidas_seguidas+="$random_number "
            let total_perdidas+=1
          fi
          if [ $money -lt $(($bet_to_renew-100)) ]; then 
            echo -e "\n${yellowColour}[+]${endcolour}${grayColour} Hemos llegado a un mínimo crítico, se procede a reajustar el tope.${endColour}"
            bet_to_renew=$(($bet_to_renew - 100))
            echo -e "\n${yellowColour}[+]${endcolour}${grayColour} El tope ha sido renovado a ${endColour}${yellowColour}$bet_to_renew€${endColour}${grayColour}.${endColour}"

            unset sequence[0]
            unset sequence[-1] 2>/dev/null

            sequence=(${sequence[@]})

            echo -e "${yellowColour}[-]${endColour}${grayColour} Nueva secuencia: ${endColour}${greenColour}[${sequence[@]}]${endColour}"
            if [ "${#sequence[@]}" -ne 1 ] && [ "${#sequence[@]}" -ne 0 ]; then
              bet=$((${sequence[0]} + ${sequence[-1]}))
            elif [ "${#sequence[@]}" -eq 1 ]; then
              bet=${sequence[@]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              sequence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a: ${endColour}${greenColour}[${sequence[@]}]${endColour} "
              bet=$((${sequence[0]} + ${sequence[-1]}))
            fi
          else
            unset sequence[0]
            unset sequence[-1] 2>/dev/null

            sequence=(${sequence[@]})

            echo -e "${yellowColour}[-]${endColour}${grayColour} Nueva secuencia: ${endColour}${greenColour}[${sequence[@]}]${endColour}"
            if [ "${#sequence[@]}" -ne 1 ] && [ "${#sequence[@]}" -ne 0 ]; then
              bet=$((${sequence[0]} + ${sequence[-1]}))
            elif [ "${#sequence[@]}" -eq 1 ]; then
              bet=${sequence[@]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia.${endColour}"
              sequence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a ${endColour}${greenColour}[${sequence[@]}]${endColour} "
              bet=$((${sequence[0]} + ${sequence[-1]}))
            fi
          fi
        fi
      fi
      else
        echo -e "${yellowColour}[!]${endColour} ${redColour}¡Te has quedado a $money!${endColour}\n"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Has perdido en la ronda $(($ronda-1))${endColour}${grayColour} con una racha de ${redColour}$(echo $perdidas_seguidas|wc -w)${endColour}${grayColour}.${endColour}"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Últimos números: ${endColour}${turquoiseColour}$perdidas_seguidas]${endColour}${grayColour}.${endColour}\n"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Total Perdidas: ${endColour}${redColour}$total_perdidas${endColour}${grayColour}.${endColour}"
        echo -e "${yellowColour}[-]${endColour} ${grayColour}Total Ganadas: ${endColour}${greenColour}$total_ganadas${endColour}${grayColour}.${endColour}\n"
        tput cnorm; exit 0
      fi
  done
}




function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso de: ${endColour}${purpleColour}$0${endColour}"
  echo -e "\t${purpleColour}m)${endColour}${grayColour} Dinero con el que desea empezar a jugar.${endColour}"
  echo -e "\t${purpleColour}t)${endColour}${grayColour} Técnica a utilizar: ${endColour} ${purpleColour}(martingala/inverseLabrouchere)${endColour}"
}


# Indicadores
declare -i parameter_counter=0

while getopts "m:t:h" arg; do
  case $arg in
    m) money="$OPTARG"; let parameter_counter+=1;;
    t) technique="$OPTARG";let parameter_counter+=2;;
    h) let parameter_counter+=99;;
  esac
done

if [ $money ] && [ $technique ];then
  echo "$technique"
  if [[ "${technique,,}" == "martingala" ]]; then 
      martingala
  elif [[ "${technique,,}" == "inverselabrouchere" ]]; then 
      inverseLabrouchere
  else
    echo -e "\n${redColour}[!] La técnica introducida no existe. Saliendo...${endcolour}"
    helpPanel
  fi  
elif [ $parameter_counter -eq 99 ]; then
  helpPanel
else
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Utiliza ${endColour}${blueColour}-h${endColour}${grayColour} para el panel de ayuda.${endColour}"
fi