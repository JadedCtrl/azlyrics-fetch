#!/bin/sh
# --------------------------------------
# name: azlyric.sh
# lisc: CC0
# date: 2020
# desc: fetches lyrics from artist/song
#       azlyrics URL
# --------------------------------------

USER_AGENT="Mozilla/5.0 (Linux; Android 8.1.0) AppleWebKit/537.36 (KHTML, like"
USER_AGENT="${USER_AGENT} Gecko) Chrome/67.0.3396.68 Mobile Safari/537.36"

function fetch {
	local url="$1"
	curl -s --user-agent "$USER_AGENT" "$url"
}

# ======================================
# ARTIST 
# ======================================
function is_artist_url {
	local url="$1"
	test -n "$(echo "$url" | awk -F '/' '{print $5}')" \
		-a -z "$(echo "$url" | awk -F '/' '{print $6}')"
	return "$?"
}

function artist_song_urls {
	grep "../lyrics/" \
	| sed 's%.*href="..%%' \
	| sed 's%".*%%' \
	| sed 's%^%https://www.azlyrics.com%'
}

# ======================================
# SONG
# ======================================
function is_song_url {
	local url="$1"
	test -n "$(echo "$url" | awk -F '/' '{print $6}')"
	return "$?"
}

function song_lyrics {
	sed '1,/Sorry about that/d' \
	| sed  '1,/<\/div>/!d' \
	| sed 's%<br>%%' \
	| sed 's%<.*>%%' \
	| awk 'BEGIN { print "<pre>" } END { print "</pre>"} {print $0}' \
	| lynx -stdin -dump
}

# ======================================
# INVOCATION
# ======================================
function usage {
	echo 'usage: azlyric.sh URL ... URL'
	echo
	echo 'If a URL is of an artist (e.g., https://www.azlyrics.com/X/X.*.html),'
	echo 'then the URLs of each song page will be printed.'
	echo
	echo 'If a URL is of a song (e.g., https://www.azlyrics.com/lyrics/X/Y.html),'
	echo 'then the lyrics will be printed.'
	exit 2
}

if test -z "$1"; then usage; fi

for url in $@; do
	if is_artist_url "$url"; then
		fetch "$url" \
		| artist_song_urls
	elif is_song_url "$url"; then
		fetch "$url" \
		| song_lyrics
	else
		echo "Invalid URL: $url"
		usage
	fi
done
