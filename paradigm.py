#!/usr/bin/env python3

import sys

s = sys.stdin.read().strip()

ls = []
lm = ''
tg = ''
for c in s:
    if c == '<':
        if lm:
            if lm == '(':
                ls.append('[')
            elif lm == ')':
                ls.append(']')
            elif lm in ['|']:
                ls.append(lm)
            else:
                ls.append('{'+lm+'}')
            lm = ''
        tg += '%'
        tg += c
    elif c == '>' and tg:
        tg += '%'
        tg += c
        if tg == '%<*%>':
            ls.append('?*')
        else:
            ls.append(tg)
        tg = ''
    elif tg:
        tg += c
    else:
        lm += c

print(' '.join(ls))
