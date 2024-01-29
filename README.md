# azlyrics-fetch
Fetch lyrics from azlyrics.com, simply and quickly.


## Installation
Simply copy azlyrics-fetch.sh into your $PATH:
`$ cp azlyrics-fetch.sh ~/.local/bin/`

### Dependencies
* [Curl](https://curl.se/)
* [Lynx](https://lynx.invisible-island.net/)
* Shell (ksh, bash)


## Usage
You can get the lyrics of a specific song like so, replacing $ARTIST and $SONG
with the artist-name and song-name, respectively:

` $ azlyrics.sh https://www.azlyrics.com/lyrics/$ARTIST/$SONG.html`

You can get a list of all song URLs of an artist, too:

`$ azlyrics.sh https://www.azlyrics.com/$A/$ARTIST.*.html`


## Meta
License is the [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)  
Author is Jaidyn Ann <jadedctrl@posteo.at>  
Sauce is at https://hak.xwx.moe/jadedctrl/azlyrics-fetch
