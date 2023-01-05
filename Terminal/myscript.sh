#!/bin/bash
mkdir dir100
cd dir100
mkdir dir101 dir102 dir103
cd dir101
touch f1.txt f2.txt f3.txt f4.json f5.json
mkdir sdir101 sdir102 sdir103
ls -la
mv f2.txt f4.json sdir101
echo "Получилось :)"