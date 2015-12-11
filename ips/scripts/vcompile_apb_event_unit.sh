#!/bin/tcsh
source scripts/colors.sh

set IP=apb_event_unit

echo "${Green}--> Compiling APB Event Unit... ${NC}"

# check if environment variables are defined
if (! $?MSIM_LIBS_PATH ) then
  echo "${Red} MSIM_LIBS_PATH is not defined ${NC}"
  exit 1
endif

if (! $?IPS_PATH ) then
  echo "${Red} IPS_PATH is not defined ${NC}"
  exit 1
endif


echo "${Green}library: apb_event_unit_lib ${NC}"
rm -rf ${MSIM_LIBS_PATH}/${IP}_lib

vlib ${MSIM_LIBS_PATH}/${IP}_lib
vmap ${IP}_lib ${MSIM_LIBS_PATH}/${IP}_lib

echo "${Green}Compiling component:   ${Brown} apb_event_unit ${NC}"
echo "${Red}"

vlog -work ${IP}_lib -quiet +incdir+${IPS_PATH}/apb/${IP}/include -sv ${IPS_PATH}/apb/apb_event_unit/apb_event_unit.sv          || exit 1
vlog -work ${IP}_lib -quiet +incdir+${IPS_PATH}/apb/${IP}/include -sv ${IPS_PATH}/apb/apb_event_unit/generic_service_unit.sv    || exit 1
vlog -work ${IP}_lib -quiet +incdir+${IPS_PATH}/apb/${IP}/include -sv ${IPS_PATH}/apb/apb_event_unit/sleep_unit.sv              || exit 1

echo "${Cyan}--> APB EVENT UNIT compilation complete! ${NC}"

