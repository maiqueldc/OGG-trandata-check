echo > gg.out
echo " dblogin USERID ggate PASSWORD AAAAAAAAAAAAAQQQQQQQQQQQKKKKKKK, encryptkey default" > template_check.tmp
echo "" >> template_check.tmp
cat dirprm/e_terada.prm|grep -i TABLE|awk {' print $1" "$2 '}|awk -F"," {' print $1 '}|sed 's/TABLE/INFO TRANDATA/g' >> template_check.tmp

./ggsci << EOF > gg.out
obey template_check.tmp
EOF

cat gg.out|sed '/^$/d'|grep -v ": ALL."|grep -v -i "info trandata"|grep -v "data is enabled for table"|grep -v "ERROR OGG-01784"|grep -v "Prepared CSN for table" |awk -F":" {' print $1 '}|while read line; do echo "add trandata $line allcols"; done > add_trandata.obey
rm template_check.tmp
#rm gg.out
