#!/usr/bin/env bash
(
set -e
PS1="$"

function changelog() {
    base=$(git ls-tree HEAD $1  | cut -d' ' -f3 | cut -f1)
    cd $1 && git log --oneline ${base}...HEAD
}
bungee=$(changelog ChestShop-3)

updated=""
logsuffix=""
if [ ! -z "$bungee" ]; then
    logsuffix="$logsuffix\n\nChestShop-3 Changes:\n$bungee"
    if [ -z "$updated" ]; then updated="ChestShop-3"; else updated="$updated/ChestShop-3"; fi
fi
disclaimer="Upstream has released updates that appears to apply and compile correctly.\nThis update has not been tested by schlatt-co and as with ANY update, please do your own testing"

if [ ! -z "$1" ]; then
    disclaimer="$@"
fi

log="${UP_LOG_PREFIX}Updated Upstream ($updated)\n\n${disclaimer}${logsuffix}"

echo -e "$log" | git commit -F -

) || exit 1
