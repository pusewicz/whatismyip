# whatismyip

The IP reporting service is available at https://yourip.herokuapp.com/.

This tiny `rack`-based application returns the client's IP address.

It also returns plain text, JSON, XML and YAML responses.

## Plain Text

`curl -H "Accept: text/plain" https://yourip.herokuapp.com`

## JSON

`curl -H "Accept: application/json" https://yourip.herokuapp.com`

## XML

`curl -H "Accept: application/xml" https://yourip.herokuapp.com`

## YAML

`curl -H "Accept: application/x-yaml" https://yourip.herokuapp.com`
