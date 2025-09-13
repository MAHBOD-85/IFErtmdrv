  CMP #$A0
  BCS donttranspose
  ADC CHXtranspose,x
donttranspose:
