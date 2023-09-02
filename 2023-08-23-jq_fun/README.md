```
jq --arg f "$(<ias.crt)" '."ca-cert" = $f' < scheme.json
```
