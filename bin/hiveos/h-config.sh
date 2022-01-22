#!/usr/bin/env bash

[[ -z $CUSTOM_TEMPLATE ]] && echo -e "${YELLOW}CUSTOM_TEMPLATE is empty${NOCOLOR}" && return 1
[[ -z $CUSTOM_URL ]] && echo -e "${YELLOW}CUSTOM_URL is empty${NOCOLOR}" && return 1
[[ -z $CUSTOM_PASS ]] && CUSTOM_PASS="x"

conf=`cat /hive/miners/custom/${CUSTOM_NAME}/config_global.json | envsubst`

[[ ! -z $CUSTOM_TEMPLATE ]] &&
	conf=`jq --null-input --argjson conf "$conf" --arg user "$CUSTOM_TEMPLATE" '$conf + {$user}'`
[[ ! -z $CUSTOM_ALGO ]] &&
	conf=`jq --null-input --argjson conf "$conf" --arg algo "$CUSTOM_ALGO" '$conf + {$algo}'`
[[ ! -z $CUSTOM_URL ]] &&
	conf=`jq --null-input --argjson conf "$conf" --arg url "$CUSTOM_URL" '$conf + {$url}'`
[[ ! -z $CUSTOM_PASS ]] &&
	conf=`jq --null-input --argjson conf "$conf" --arg pass "$CUSTOM_PASS" '$conf + {$pass}'`

if [[ ! -z $CUSTOM_USER_CONFIG ]]; then
	while read -r line; do
		[[ -z $line ]] && continue
		conf=$(jq -s '.[0] * .[1]' <<< "$conf {$line}")
	done <<< "$CUSTOM_USER_CONFIG"
fi

echo $conf | jq . > $CUSTOM_CONFIG_FILENAME

exit 0
