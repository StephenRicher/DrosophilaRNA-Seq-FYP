#!/usr/bin/awk -f

function header_line() {
    return NR % 4 == 1
}

function sequence_line() {
    return NR % 4 == 2
}

function opt_line() {
    return NR % 4 == 3
}

function quality_line() {
    return NR % 4 == 0
}


BEGIN {
    FS=""
    SUBSEP=","
}


{
if (quality_line()) {
    for (pos = 1; pos <= NF; pos++) {
        baseQ_freq[pos, $pos] += 1
    }
}
}

END {
    printf "pos,phred,count\n"
    for (pos_and_baseQ in baseQ_freq) {
        freq = baseQ_freq[pos_and_baseQ]
        split(pos_and_baseQ, sep, SUBSEP)
        printf "%s,%s\n", pos_and_baseQ, freq
    }
}
