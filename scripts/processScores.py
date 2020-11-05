#!/usr/bin/env python

import sys
import json
import pandas as pd

try:
    infile = sys.argv[1]
except IndexError:
    infile = sys.stdin

allScores = pd.read_csv(infile).groupby('pos')

posScores = {}
for pos, scores in allScores:
    scoreDist = []
    totalReads = scores['count'].sum()
    propReads = list(round(100 * scores['count'] / totalReads))
    for phred, count in zip(scores['phred'], propReads):
        scoreDist.extend([phred] * int(count))
    posScores[str(pos)] = scoreDist

json.dump(posScores, sys.stdout)
