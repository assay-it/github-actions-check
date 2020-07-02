#!/bin/sh -l

/go/bin/assay \
  -api latest.assay.it \
  -secret $1 \
  -head $2 \
  -base $3 \
  -number $4 \
  -title $5
