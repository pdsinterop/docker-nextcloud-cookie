#!/bin/bash
export REQUESTTOKEN=`curl -c cookies.txt --dump-header header.txt --silent --insecure -X GET "$SERVER_ROOT/login"|grep "requesttoken"|sed -n 's/.*data-requesttoken="\([^"]*\)".*/\1/p' | sed -e 's/[+]/%2B/g'`
export INIT_COOKIE=`cat header.txt |grep Set-Cookie |grep -E "(Host-nc|oc_session)" | sort -u |sed -e 's/Set-Cookie: //'|sed -e 's/; .*/; /i' |tr -d '\r\n'`
export OLD_SESSION=`cat header.txt |grep Set-Cookie |grep -v -E "(Host-nc|oc_session)" | sort -u |sed -e 's/Set-Cookie: //'|sed -e 's/; .*/; /i' |tr -d '\r\n'`
export PAYLOAD="user=$USERNAME&password=$PASSWORD&rememberme=1&timezone=Europe/Amsterdam&timezone_offset=2&requesttoken=$REQUESTTOKEN"
export COOKIE=`curl -b cookies.txt --silent --insecure --dump-header - -X POST "$SERVER_ROOT/login" -H "Content-Type: application/x-www-form-urlencoded" -H "Origin: $SERVER_ROOT"  --data "$PAYLOAD" |grep "Set-Cookie" |grep -v "$OLD_SESSION" |sort -u |sed -e 's/Set-Cookie: //'|sed -e 's/; .*/; /i' |tr -d '\r\n'`
export COOKIE="$INIT_COOKIE$COOKIE"
echo $COOKIE
