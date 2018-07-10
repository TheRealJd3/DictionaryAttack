#!/bin/bash
# Simple line count example, using bash provided by Hans Wolfgang-Loidl
# Edits made to be compatible with coursework 1 to find the decryption key
#by Jason Shawn D'Souza H00202543
# with the scenarios of the coursework guidelines
# Bash tutorial: http://linuxconfig.org/Bash_scripting_Tutorial#8-2-read-
#file-into-bash-array
# My scripting linked:
# http://www.macs.hw.ac.uk/~hwloidl/docs/index.html#scripting
# #
# # Usage: ./task6.sh <file with possible keys> <a file to compare decrypted
# text with possible key> <the actual decrypted file>
# #eg: task6.sh words.txt compare.txt some.txt
# ( NOTE: compare.txt has to
# be plaintext file and some.txt should contain the decrypted text
# ------------------------------------------------------------------------
-----
# Link filedescriptor 10 with stdin
exec 10<&0
# stdin replaced with a file supplied as a first argument
exec < $1
in=$1
compare=$2
some=$3
key="FINALKEY.txt"
while read LINE
do
echo $LINE
SSL=`openssl enc -aes-128-cbc -d -in some.aes-128-cbc -out $compare
-nosalt -k $LINE`
#echo SSL
#Nested if loop this first if condition is to check the exit status of the
# above command
#Using line_count.sh as reference this condition was modified( -eq instead
# of -ne)
#Since the exit status would be 0 for a successfull decryption
if [ $? -eq 0 ]; then
#This condition compares the decryption with key from a line of the
# inputted file to that
#of the already provided decrypted file on vision
if [[ $(<$compare) == $(<$some) ]] ;then
echo "The key is $LINE"
#echo $LINE > keystmp.txt
echo "The key is $LINE" > $key
echo "Key found ! Terminating.."
exit 1
fi
fi
done
echo "The key is `cat ${key}`"
# restore stdin from filedescriptor 10
# and close filedescriptor 10
exec 0<&10 10<&-