#!/usr/bin/env python
import sys
import getopt
from os.path import expanduser, splitext
from commands import getoutput

def getTokenFromConf():
    conf = file(expanduser('~/.morserc'), "r")
    t = conf.readline().strip()
    conf.close()
    return t

def getSyntaxFromExt(filename):
    if splitext(filename)[1]:
        return splitext(filename)[1][1:]
    else:
        return '-'

try:
    opts, args = getopt.gnu_getopt(sys.argv[1:], 'tl: ', ['token=', 'no-login'])
except getopt.GetoptError:
    print("usage...")
    sys.exit(0)

curlArgs=['curl']
syntax = False
filename = False
token = False
nologin = False

for opt, arg in opts:
    if opt == '-l':
        curlArgs += ['-F']
        curlArgs += ['"paste[syntax]='+arg+'"']
        syntax = True
    if opt == '-t' and not syntax:
        curlArgs += ['-F']
        curlArgs += ['"paste[syntax]=text"']
        syntax = True
    if opt == '--token':
        token = True
        curlArgs += ['-F']
        curlArgs += ['"auth_token='+arg+'"']
    if opt == '--no-login':
        nologin = True


if not token and not nologin:
    curlArgs += ['-F']
    curlArgs += ['"auth_token='+getTokenFromConf()+'"']

if args:
    filename=args[0]

if not syntax and filename:
    curlArgs += ['-F']
    curlArgs += ['"paste[syntax]='+getSyntaxFromExt(filename)+'"']

if not syntax:
        curlArgs += ['-F']
        curlArgs += ['"paste[syntax]=-"']

if filename:
    curlArgs += ['-F']
    curlArgs += ['"paste[name]='+filename+'"']
    curlArgs += ['-F']
    curlArgs += ['"paste[file]=@'+filename+'"']
else:
    curlArgs += ['-F']
    curlArgs += ['"paste[file]=@-"']

curlArgs += ['http://morse.swirski.name/pastes.shell']
print(getoutput(' '.join(curlArgs)))