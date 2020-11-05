#!/usr/bin/env python

import sys
import json
import random

phredCounts = sys.argv[1]
infile = sys.argv[2]

readLength = 76
adapter = 'AGATCGGAAGAGCACACGTCTGAACTCCAGTCA'
# Add a random sequence of bases to end
for i in range(readLength):
    adapter += random.choice(['A', 'T', 'C', 'G'])


def isHeader(NR):
    return NR % 4 == 0

def isSequence(NR):
    return NR % 4 == 1

def isOpt(NR):
    return NR % 4 == 2

def isQuality(NR):
    return NR % 4 == 3


with open(phredCounts) as fh:
    phredScores = json.load(fh)

with open(infile) as fh:
    for i, line in enumerate(fh):
        if isHeader(i):
            print(f'@{i}')
        elif isSequence(i):
            sequence = line.strip()
            seqLength = len(sequence)
            if seqLength != readLength:
                sequence += adapter
                sequence = sequence[:readLength]
            print(sequence)
        elif isOpt(i):
            print('+')
        else:
            quality = line.strip()
            for pos in range(seqLength, readLength):
                quality += random.choice(phredScores[str(pos)])
            print(quality)
