# whatismyip

The IP reporting service.

This tiny `rack`-based application returns the client's IP address.

It also returns plain text, JSON, XML and YAML responses.

## Plain Text


```
curl -H "Accept: text/plain" http://localhost:3000
```

## JSON

```
curl -H "Accept: application/json" http://localhost:3000
```

## XML

```
curl -H "Accept: application/xml" http://localhost:3000
```

## YAML

```
curl -H "Accept: application/x-yaml" http://localhost:3000
```

## Deploy to Render

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
