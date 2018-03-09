# whatismyip

The IP reporting service is available at https://yourip.herokuapp.com/.

This tiny `rack`-based application returns the client's IP address.

It also returns plain text and JSON responses.

## Plain Text

`curl -H "Accept: text/plain" https://yourip.herokuapp.com`

## JSON

`curl -H "Accept: application/json" https://yourip.herokuapp.com`
