'<ADbasic Header, Headerversion 001.001>
' Process_Number                 = 2
' Initial_Processdelay           = 4000
' Eventsource                    = External
' Control_long_Delays_for_Stop   = No
' Priority                       = High
' Version                        = 1
' ADbasic_Version                = 5.0.8
' Optimize                       = Yes
' Optimize_Level                 = 1
' Info_Last_Save                 = DUTTLAB8  Duttlab8\Kai
'<Header End>
' Measure.bas
' Configured as Process 2, Priority High, External trigger.


#Include ADwinGoldII.inc
DIM s,r,i AS LONG


init:
  Cnt_Enable(0)
  Cnt_Mode(1,8)          ' Counter 1 set to increasing
  
  Cnt_Clear(1)           ' Clear counter 1
  i=0
  s=0
  r=0
  Par_10=0


event:
  Cnt_Enable(1)          ' enable counter 1
  CPU_Sleep(Par_3/10)          ' count time 300ns
  Cnt_Enable(0)          ' disable counter 1
  s=s+Cnt_Read(1)        ' accumulate sig
  Cnt_Clear(1)           ' Clear counter 1
  CPU_Sleep(Par_4/10)         ' reset time 2000ns
  Cnt_Enable(1)          ' enable counter 1
  CPU_Sleep(Par_3/10)          ' count time 300ns
  Cnt_Enable(0)          ' disable counter 1
  r=r+Cnt_Read(1)        ' accumulate ref
  Cnt_Clear(1)           ' Clear counter 1
  Inc(i)
  Par_20=i
  IF (i>=Par_5) THEN
    Par_1=s
    Par_2=r
    s=0
    r=0
    i=0
    Inc(Par_10)
  ENDIF


finish:
  Cnt_Enable(0)
