mkdir $2
sudo nmap -p- -sS --min-rate 5000 --open -vvv -n -Pn $1 > result.txt
cat result.txt | grep -i -E -w -v 'Discovered|not' | grep "tcp" | awk '{print $1}' | tr '\n ' ' ' | awk 'NF' |
sed 's/\/tcp/ /g' | xargs echo | sed 's/ /,/g' > ports.txt
sudo nmap -sCV -p$(cat ports.txt) $1 -stylesheet=https://raw.githubusercontent.com/honze-net/nmap-bootstrap-xsl
/stable/nmap-bootstrap.xsl -oX $2/targetedXML > $2/services.txt
rm ports.txt
rm result.txt
cat $2/services.txt
