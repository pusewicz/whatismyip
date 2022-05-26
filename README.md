# whatismyip

The IP reporting service is available at https://yourip.fly.dev.

This tiny `rack`-based application returns the client's IP address.

It also returns plain text, JSON, XML and YAML responses.

## Plain Text


```
curl -H "Accept: text/plain" https://yourip.fly.dev
```

## JSON

```
curl -H "Accept: application/json" https://yourip.fly.dev
```

## XML

```
curl -H "Accept: application/xml" https://yourip.fly.dev
```

## YAML

```
curl -H "Accept: application/x-yaml" https://yourip.fly.dev
```
