#!/usr/bin/env bash
bg=""			#Initialise variables
filename=""
first=""
second=""

usage(){					#Help function
	cat << EOF
Meme
Description: A meme generator
Usage: meme.sh [-h] [(-m <background>)] [(-t <top_text>)] [(-b <bottom_text>)] [(-f <filename>)]
	-h Show this help message
	-m Choose meme background
	-t Choose the top text 
	-b Choose the bottom text
	-f Choose the filename
Examples:
	meme -h
	meme -m doge -t foo -b bar -f meme.jpg
EOF
}

main() {
	if [[ "$bg" == "" ]]; then
		echo -n "Enter the name for the meme's background (Ex. buzz, doge, blb ): "
		read -r bg
	fi
	if [[ "$first" == "" ]]; then
		echo -n "Enter the text for the first line: "	#echo -n removes /newline
		read -r first
	fi
	if [[ "$second" == "" ]]; then
		echo -n "Enter the text for the second line: "
		read -r second
	fi
	if [[ $filename == "" ]]; then	#Opening if statement
		echo -n "Enter a filename: "
		read -r filename
	fi  							#Closes if statement 
	# curl -s "https://memegen.link/$bg/$first/$second.jpg" > "$filename" || return 1  # >> append , > overwrite, -s == no output
	wget -qO "$filename" "https://memegen.link/$bg/$first/$second.jpg" || return 1 #q for quiet O pipe to filename
	return 0
}

#Allows the user to set all the vars on first line using -m buzz -t hello -b world -f filename.jpg
while getopts ":hm:t:b:f:" opt; do   #getopts gets argv and stores it in opt # : means the letter is followed by something 
	case "$opt" in                  #case == a tonne of elifs
	h)
		usage
		exit 0
		;;
	m)
		bg=$OPTARG                  #optarg
		;;							# ;; == mandatory
	t)
		first=$OPTARG
		;;
	b)
		second=$OPTARG
		;;
	f)
		filename=$OPTARG
		;;
	\?)
		echo "Invalid option: -$OPTARG" >&2       #>&2 filters to standard error
		exit 1
		;;
	:)
		echo "Option -$OPTARG requires an argument." >&2
		;;
	esac
done

main || exit 1	#exectues main
exit 0			#exits script