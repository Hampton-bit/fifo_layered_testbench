#!/bin/csh

source ~/cshrc
xrun -f file.f -access +rwc -coverage U -covdut top -covoverwrite -gui 
# -coverage U -covdut testbench -covoverwrite
# imc -load /home/cc/Downloads/SV_module/Lab40_layered_testbench/cov_work/scope/test
#imc -load /home/cc/Downloads/SV_module/layered_FIFO_Verification/layered/cov_work/scope/test

 #imc -load all -db cov_work/scope/test/icc_*.ucd