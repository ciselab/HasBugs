# Rhodos Templater

This little script helps to create most `.sh` files from a `datapoint.json`.

## How to run 

Stay in this repository, as otherwise, well, you need the templates in 
`./templates` nearby but if you are in the wrong repo it will tell you.

Then you just run 

```sh
python main.py path/to/datapoint.json ../../references/sample/5
```

It's ok if you're datapoint is in the references folder already. 
It's ok to re-run the program with the same params - if the datapoint changed, 
the according files will be overwritten. 

**If any attributes were missing from the, they will be filled with unusable placeholders**, 
meaning everything that was missing has to be added manually.

**This program does not create the patches, so you have to do that yourself**.