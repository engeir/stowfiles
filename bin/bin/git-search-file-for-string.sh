#!/bin/bash

export File="./src/ensemble_run_analysis/analysis/forcing_linearity.py"
for Hash in $(git rev-list HEAD -- $File); do
    git grep -i -F "c2c" $Hash:$File;
done
