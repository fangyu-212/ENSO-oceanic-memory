#!/bin/ksh

# 13/12/2023 - N.Lebas
# Create NEMO simulations to explore El Nino/La Nina asymetry from a CTRL simulation.
# Restart periodicaly each year from YR_end to YR_end

############ VAR INIT ############
modDir=/ccc/work/cont003/gen1140/liufangy/NEMOGCM_For_SETE/modipsl # modIPSL dir
libIGCM=${libIGCM:=${modDir}/libIGCM}
simDir=${modDir}/config/NEMO_v6/eOR1-IA-FLX-29 # experiment template dir

oriSimName=Template
ensDirName=eOR1-IA-FLX-29-ensemble

SUB_PROJECT=gen1140
PACK_FREQ="3Y"
TIMS_FREQ="NONE"
SEAS_FREQ="NONE"

ENS_MERGE_SAVE="y" # put all the outputs in the same directory
SIM_LEN=3 # simulation length in years

PERIOD_NB=3 # Job file periodNb
WALLTIME=21600 # Time for job simulation

# Restart years first and last
YR_beg=1958
YR_end=2018


## Load part of libIGCM functions to read card files
. ${libIGCM}/libIGCM_debug/libIGCM_debug.ksh
. ${libIGCM}/libIGCM_card/libIGCM_card.ksh

# Create output script files
qsubFile=Qsub.${ensDirName}.sh
qclrPerF=Qclean_or_continue.job.${ensDirName}.sh
qclrPacF=Qclean.latestPackperiod.${ensDirName}.sh

# generate restart years
RSTT_DATE=($(seq $YR_beg $YR_end))
nDATE=$((${#RSTT_DATE[@]}-1))

############ PROCESS ############
echo "cd $simDir"
cd $simDir

echo "#!/bin/bash" > $simDir/$qsubFile
echo "#!/bin/bash" > $simDir/$qclrPerF
echo "#!/bin/bash" > $simDir/$qclrPacF

echo "mkdir $ensDirName"
mkdir -p $ensDirName

echo "ln -s ${simDir}/../ARCH ${ensDirName}/ARCH"
ln -s ${simDir}/../ARCH ${ensDirName}/ARCH

### Dir creation
for i in {0..$nDATE}
do
    ip1=$(($i + 1)) # start with i=1 for member name (not 0)
    if [ $ip1 -lt 10 ] # simu name (add 0 if < 10)
    then
	curSim=$ensDirName-0$ip1
    else
	curSim=$ensDirName-$ip1
    fi
    curSimDir=$ensDirName/$curSim # simu path
    
    echo "cp -R $oriSimName $curSim"
    cp -R $oriSimName $curSimDir
    
    echo "cd $curSimDir"
    cd $curSimDir
        
    echo "rm -rf Debug/ Script_Output* run.* Job_* pack*.job config.card.*"
    rm -rf Debug/ Script_Output* run.* Job_* pack*.job config.card.*
    
    echo "Create symbolic links for: POST PARAM DRIVER COMP"
    ln -s ${simDir}/POST
    ln -s ${simDir}/PARAM
    ln -s ${simDir}/DRIVER
    ln -s ${simDir}/COMP
    
    IGCM_card_WriteOption config.card UserChoices JobName "$curSim"
    IGCM_card_WriteOption config.card UserChoices DateBegin $((RSTT_DATE[${i}]+1))"-01-01"
    IGCM_card_WriteOption config.card UserChoices DateEnd $((RSTT_DATE[${i}]+${SIM_LEN}))"-12-31"
    
    IGCM_card_WriteOption config.card Ensemble EnsembleName $ensDirName
    IGCM_card_WriteOption config.card Ensemble EnsembleType "Ens_DATE_periodic"
    IGCM_card_WriteOption config.card Ensemble EnsembleMergeSave $ENS_MERGE_SAVE
    
    IGCM_card_WriteOption config.card Post PackFrequency $PACK_FREQ
    IGCM_card_WriteOption config.card Post TimeSeriesFrequency $TIMS_FREQ
    IGCM_card_WriteOption config.card Post SeasonalFrequency $SEAS_FREQ
    
    IGCM_card_WriteOption config.card Restarts OverRule "y"
    IGCM_card_WriteOption config.card Restarts RestartDate ${RSTT_DATE[${i}]}"-12-31"
    IGCM_card_WriteOption config.card OCE Restart "n"
#    IGCM_card_WriteOption config.card ICE Restart "n"
#    IGCM_card_WriteOption config.card MBG Restart "n"
    IGCM_card_WriteOption config.card IOS Restart "n"
    
    echo "cd $simDir"
    cd $simDir
    
    curJobFile=Job_$curSim
    echo "cd $curSimDir;  >> ${simDir}/${qsubFile}"
    echo "ccc_msub ${curJobFile}; cd -;  >> ${simDir}/${qsubFile}"
    
    echo "cd $curSimDir;" >> $simDir/$qsubFile
    echo "ccc_msub ${curJobFile}; cd -;" >> $simDir/$qsubFile

    echo "cd $curSimDir;" >> $simDir/$qclrPerF
    echo "${libIGCM}/clean_or_continue.job -f; cd -;" >> $simDir/$qclrPerF
    
    echo "cd $curSimDir;" >> $simDir/$qclrPacF
    echo "${libIGCM}/clean_latestPackperiod.job; cd -;" >> $simDir/$qclrPacF
done

### Job creation
for i in {0..$nDATE}
do
    ip1=$(($i + 1)) # start with i=1 for member name (not 0)
    if [ $ip1 -lt 10 ] # simu name (add 0 if < 10)
    then
	curSim=$ensDirName-0$ip1
    else
	curSim=$ensDirName-$ip1
    fi
    curSimDir=$ensDirName/$curSim # simu path
    
    echo "cd $curSimDir"
    cd $curSimDir
    
    echo "${libIGCM}/ins_job -p ${SUB_PROJECT} -q xlarge -c 8 -t ${WALLTIME}"
    $libIGCM/ins_job -p ${SUB_PROJECT} -q xlarge -c 8 -t ${WALLTIME}
    
    curJobFile=Job_$curSim
    sed -e "s/^PeriodNb=.*/PeriodNb=${PERIOD_NB}/" $curJobFile > $curJobFile.tmp
    mv $curJobFile.tmp $curJobFile
    
    echo "cd $simDir"
    cd $simDir
done

echo "End..."
