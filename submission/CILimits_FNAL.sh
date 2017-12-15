#!/bin/bash

#echo "first arg: "$1
DATE=`date +%Y%m%d`
CONFIG=$1
LABEL=$2
SRC=$3
DATACARD=$4
NINT=$5
NTOYS=$6
NTOYSEXP=$7
LAMBDA=$8
RANGE=$9
TAG=${10}
SINGLEBIN=${11}
MASSCUT=${12}
echo ${SRC}
echo $DATACARD
echo $NINT
echo $NTOYS
echo $NTOYSEXP
echo $LAMBDA
echo $TAG
ARGS=("$@")
LIBPART=""
END=$#


Name=${CONFIG}${LABEL:1}

# PBS8parameters
#PBS -q cms
#PBS -N obslimit_$m-$DATE-$Run
#PBS -l walltime=06:00:00
# Send me an email on  a=abort, b=begin, e=end
##PBS -m e
#PBS -e /home/bradburn/output/obslimit_$m-$DATE-$Run.err
#PBS -o /home/bradburn/output/obslimit_$m-$DATE-$Run.log
# Merge standard output and error streams 
#PBS -j oe
#PBS -r n
#PBS -V
# ---------------------------------------------------------
#

if [ -d "$_CONDOR_SCRATCH_DIR/" ]; then
    workdir=`echo $_CONDOR_SCRATCH_DIR/`;
    cd ${workdir};
fi


set nonomatch

echo ""
echo "Job is running on `uname -a`"
set processor = `sort /proc/cpuinfo | uniq | gawk -F: '(substr($1,1,10)=="model name"){print $2}'`
set rate = `sort /proc/cpuinfo | uniq | gawk -F: '(substr($1,1,7)=="cpu MHz"){print substr($2,1,6)}'`
echo "Processor info : " $processor $rate "MHz"
set start = `date`
echo "Job started on `date`"
echo ""

#
#----------------------------------------------------------
# s e t   t h e   r u n t i m e   e n v i r o n m e n t
#----------------------------------------------------------
#
export OUTDIR=$SRC/results_${Name::${#Name}-6}
if [[ $DATACARD == *"binned"* ]]
then
  export OUTDIR=$SRC/results_${Name}_binned;
fi

export WORKDIR=${workdir}

echo " "
echo "Output directory is : " $OUTDIR
echo " "

#
#----------------------------------------------------------
# s e t   t h e   r u n t i m e   e n v i r o n m e n t
#----------------------------------------------------------
#
source /cvmfs/cms.cern.ch/cmsset_default.sh
#cd ${SRCDIR}/src
#echo "Current directory is : " $SRCDIR/src
eval `scramv1 runtime -sh`
#source /home/sfolguer/StatsRoot/bin/thisroot.sh
#cd ZPrimeStats
cd ${SRCDIR}

#----------------------------------------------------------
# c o p y   e x e   a n d   c o n f i g    f i l e s
#----------------------------------------------------------
#

mkdir ${WORKDIR}
cd ${WORKDIR}
mkdir dataCards_${Name}
ls
#
#----------------------------------------------------------
# e x e c u t e   j o b
#----------------------------------------------------------
#
zero=0;
cd $SRC
if [[ $SINGLEBIN -eq $zero ]]; then
python runInterpretation.py -c $CONFIG -m $LAMBDA -w -t ${LABEL:2} --workDir $WORKDIR --CI
else
python runInterpretation.py -c $CONFIG -m $LAMBDA -w -t ${LABEL:2} --workDir $WORKDIR --singlebin -m $MASSCUT --CI
fi
cd ${WORKDIR}
echo $DATACARD

if [[ $NTOYSEXP -eq $zero ]]; then
combine -M MarkovChainMC dataCards_${Name}/${DATACARD} -n ${Name} -m $LAMBDA -i $NINT --tries $NTOYS --prior flat --rMax $RANGE  $LIBPART 
else
combine -M MarkovChainMC dataCards_${Name}/${DATACARD} -n $Name -m $LAMBDA -i $NINT --tries $NTOYS -t $NTOYSEXP --prior flat --rMax $RANGE $LIBPART -s 0
fi

#
#----------------------------------------------------------
# c o p y   o u t p u t
#----------------------------------------------------------
#
if [ ! -d "$OUTDIR" ]; then
mkdir ${OUTDIR}
fi
if [ ! -d "$OUTDIR/$TAG" ]; then
mkdir ${OUTDIR}/$TAG
fi
echo "Finished -- ls dir: "
pwd
ls -lrt | tail
echo "Copying to " ${OUTDIR}/$TAG
if [[ $NTOYSEXP -eq $zero ]]; then
cp ${WORKDIR}/*.root ${OUTDIR}/$TAG/
else
cp ${WORKDIR}/higgsCombine${Name}.MarkovChainMC.mH${LAMBDA}.0.root ${OUTDIR}/$TAG//higgsCombine${Name}.MarkovChainMC.mH${LAMBDA}.${NTOYS}.root
fi
echo "what is in " ${OUTDIR}/$TAG
ls -lrt ${OUTDIR} | tail

#
# show what is being left behind...
#
#  echo ""
#  echo "Current directory:"
#  pwd
#  ls -lrt
#
  end=`date`
  echo ""
  echo "Job end `date`"
  echo ""
# 
#
#rm -r ${WORKDIR}/*
#exit ${status}

