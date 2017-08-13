#!/usr/bin/env python
#versão: 0.1
# -*- coding: iso-8859-1 -*-
#from numpy import *
#import pylab as p
import sys
print len(sys.argv)
if len(sys.argv)<2:
    print "Erro: preciso de um argumento."
    raise SyntaxError
f=open(sys.argv[1],'r')
a=f.readlines()
n=len(a)
print n
s=" "
for i in range(0,n-1):
    if not (a[i].find('\\\\begin{document}')):
         break
 
k=i
print "parou na linha",i
for i in range(k+1,n-1):
    a[i]=a[i].replace('\\n',' ') 
    print i,'->',a[i]
    s=s + a[i]
 
s=s.replace(" $"," $latex ")
#s=s+"$"
print s
