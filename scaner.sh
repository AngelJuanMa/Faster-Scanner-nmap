sudo nmap -p- -sS --min-rate 5000 --open -vvv -n -Pn $1 > result.txt
cat result.txt | grep -i -E -w -v 'Discovered|not' | grep "tcp" | awk '{print $1}' | tr '\n ' ' ' | awk 'NF' | sed 's/\/tcp/ /g' | xargs echo | sed 's/ /,/g' > ports.txt
nmap -sCV -p$(cat ports.txt) $1 > services.txt
rm ports.txt
rm result.txt
cat services.txt