import os

def isSourceFile( fileName ):

    tokens = fileName.split('.')
    return len(tokens)>1 and tokens[-1] in ['c','cpp','h','hpp','py','java']

for step in os.walk('.'):

    currentDirectory, subdirectories, files = step
    sourceFiles = filter( isSourceFile, files )
    for file in sourceFiles:
        print '\\'.join((currentDirectory+'\\'+file).split('\\')[1:])

