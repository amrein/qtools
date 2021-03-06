#!/bin/bash

# make sure we are using this copy of the scripts
source ../../../../qtools_init.sh

# get the diffing function and some variable
source ../../common.sh

ROOTDIR=$(pwd)
mkdir -p $TESTDIR
cd $TESTDIR

rm test_000/* 2>/dev/null
rmdir test_000 2>/dev/null

q_genfeps.py ../input/genfeps.proc \
             ../input/1-relax/relax_003.inp \
             relax \
             --repeats 1 \
             --frames 51 \
             --fromlambda 0.5 \
             --pdb ../input/0-topol/probr_cl_start.pdb \
             --energy_list_fn random_name.list \
             --prefix test_ >> ${STDOUT}

for i in test_000/*
do
    sed -i 's/#.*//' $i
done

echo "Checking outputs"
run_diff "diff test_000 $ROOTDIR/output/test_000"

cd $ROOTDIR
