# Objects to CSV

This isn't so much a remarkable thing:  It's a stack overflow example
that's saved to a file.

However, it shows how to run jq expressions as a script file, which
seems nice.  Just chmod +x the file, and run it with a json file:

```
./objects_to_csv.jq example.jsonl
```
