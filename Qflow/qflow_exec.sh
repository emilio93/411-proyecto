#!/usr/bin/tcsh -f
#-------------------------------------------
# qflow exec script for project /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW
#-------------------------------------------

# /usr/lib/qflow/scripts/synthesize.sh /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1
# /usr/lib/qflow/scripts/placement.sh -d /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1
# /usr/lib/qflow/scripts/vesta.sh /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1
# /usr/lib/qflow/scripts/router.sh /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1
# /usr/lib/qflow/scripts/placement.sh -f -d /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1
# /usr/lib/qflow/scripts/router.sh /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1 $status
/usr/lib/qflow/scripts/cleanup.sh /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1
# /usr/lib/qflow/scripts/display.sh /home/du/Files_du/UCR/II_18/MicroE/PROYECTO/QFLOW data_selector || exit 1
