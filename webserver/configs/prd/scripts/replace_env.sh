#!/bin/bash

echo "Deny List $LCP_DENY_LIST"

ls -la conf.d/liferay.conf

if [[ -z ${LCP_DENY_LIST} ]]; then
    export LCP_DENY_LIST=""
fi

echo "Deny List $LCP_DENY_LIST"

sed -i 's@LCP_DENY_LIST@'"$LCP_DENY_LIST"'@' conf.d/liferay.conf

cat conf.d/liferay.conf


