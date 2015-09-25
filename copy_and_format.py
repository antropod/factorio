#!/usr/bin/env python

# Copy file `recipes` from Factorio script-output folder
# and pretty-print it to `recipes.json`

import json
import os

SCRIPT_OUTPUT = os.path.join(
  os.environ['APPDATA'],
  'Factorio',
  'script-output',
  'recipes'
)

def main():
    with open(SCRIPT_OUTPUT) as fp:
        obj = json.load(fp)
        
    with open('recipes.json', 'w') as out:
        json.dump(obj, out, indent=1, sort_keys=True)

if __name__ == '__main__':
    main()