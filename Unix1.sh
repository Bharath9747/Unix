#!/usr/bin/env bash
declare -a column_name
declare -a value

{
# read the first row ie column names
  IFS=, read -r -a column_name
# read the row one by one ie records  
  while IFS=, read -r -a value; do

    s="active"
	d=2023
	da=12
    val=${value[7]:3:4}
	val2=${value[7]:1:1}
	val1=${value[7]:0:1} 
	# date Validation
	if (( $d > $val ))
	then
			s="expired"
	else
		if (( $d == $val && $val1 == 0))
			then
				s="expired"
			
		elif (( $d == $val &&  $val1==1 && $val2==1))
			
		then
			s="expired"
		fi
	fi
	#Create Folder
	if [ -d "${value[2]}" ]; then
	cd "${value[2]}"
	else
	mkdir "${value[2]}"
	cd "${value[2]}"
	fi
	#Create Subfolder
	if [ -d "${value[1]}" ]; then
	cd "${value[1]}"
	else
	mkdir "${value[1]}"
	cd "${value[1]}"
	fi
	
	# Adding Records in a file
	for (( i=0;i<10;i++ ))
	do
		echo "${column_name[i]}: ${value[i]}"  >> ${value[3]}.$s
	done
	# Changing Dollar format
	cr="${value[10]}"
	
	len=${#cr}
	fl=$((len-1))
	declare -a dr
	dr=("${cr: -4}")
	for ((i=fl-3;i>0;i-=2)); do
		j=0
		f=$((i-2))
		if(($f>=0));
		then
			j=$((f))
		else
			dr=("${cr: 0:1}" "${dr[@]}")
			break
		fi
		dr=("${cr: j:2}" "${dr[@]}")
	done
	dr_s=$(IFS=','; echo "${dr[*]}")
	
	ms='$'

	echo "Credit Limit:$ms $dr_s"  >> ${value[3]}.$s
	cd "/mnt/c/Unixsession"
	
	
  done
} < Record.csv