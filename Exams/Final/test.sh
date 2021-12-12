#!/bin/bash

rm -f output/*
cp tpch.sqlite.base tpch.sqlite

python3 Final.py
