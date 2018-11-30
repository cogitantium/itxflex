# ITXflex
This repo attemps to build a proof-of-concept equivalent of [ITXflex](http://www.arcanic.dk/produkter/itx-flex) for Linux since Aalborg University seem reluctant to do acquire one themselves.

## Features
* Output filename is appended id and detailed timestamp

## todo
* Document awareness
  * Activity measuring, if a large increase in text happens between update intervals, cheating could be happening
    * Measure unformatted text in libreoffice document (`.odt`)
    * Define good parameters for sensitivity of activity - note that sequential edits are more suspect than periodical edits, as search-replace editing might yield false-postive
* Networking
  * `rsync` setup for remote server realtime update - can async work?
  * Fetch encrypted assignment 
* User-interface
  * `ncurses`?
  * Some easy-to-use interface for the novice linux user, who rarely sees a terminal
* Security
  * Ensure `ntpd` synced localtime for release of assignment and submission of document
  * Receive encrypted assignment and keys at release-time from remote server
