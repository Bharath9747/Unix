#Storing Subfolders name
rm direct.txt
find -mindepth 2 -type d >> direct.txt
ocsv="output.csv"
#Storing subfolders files names
rm subfile.txt
while IFS= read -r sp; do
find "$sp" -type f >> subfile.txt
done < direct.txt
#writing the columnnames
rm output.csv
while IFS= read -r sf; do
	c=""
	while IFS=":" read -r cna nna; do
		 c+=$cna","
	done < "$sf"
	echo $c >> "$ocsv"
break
done < subfile.txt
#writing the records

while IFS= read -r sf; do
	c=()
	while IFS=":" read -r cna nna; do
		 c+=("$nna")
	done < "$sf"
	
	cr=${c[10]}
	dr=$(echo "$cr" | tr -d ',' | tr -d '$' | tr -d ' ')
	n=10
	c[$n]=$dr
	d=""
	for i in "${c[@]}"; do
		d+=$i","
	done
	d=${d%?}
	echo $d >> "$ocsv"
done < subfile.txt