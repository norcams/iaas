Sjekke status på HAproxy-tjenestene
-----------------------------------

watch 'echo "show stat" | nc -U /var/lib/haproxy/stats | cut -d "," -f 1,2,5-11,18,24,27,30,36,50,37,56,57,62 | column -s, -t'

Liste ut IPer som aksesserer frontend_public og antall forekomster fra HAProxy-log
----------------------------------------------------------------------------------

grep 'frontend_public' /opt/log/norcams.log | cut -d' ' -f5 | grep -v Proxy | cut -d':' -f1  | sort -n | uniq -c | sort -n
