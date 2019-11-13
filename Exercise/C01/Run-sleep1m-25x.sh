GSUB='/opt/sas/config/Lev1/Applications/SASGridManagerClientUtility/9.4/sasgsub -METAPASS Student1';
PROG_FOLDER='/opt/sas/Workshop/Exercise/C01/';
OPTS="";

for i in `seq 1 25`;
do
  $GSUB -GRIDSUBMITPGM $PROG_FOLDER/sleep1.sas -GRIDJOBNAME Job_sleep1m_$i $OPTS
done

echo "*******************************************"
echo " 25 jobs were submitted to the NORMAL queue"
echo "*******************************************"