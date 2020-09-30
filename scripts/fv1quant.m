# Quantise filter coefficients for FV-1
1;

# Saturate value
function sv=qsat(v,minval,maxval)
  sv = min(v,maxval);
  sv = max(sv,minval);
endfunction
# S1_9
function [Bq,Aq]=qs19(B,A)
  [Bq,Aq]=quantsat(B,A,512,-1024,1023);
endfunction
# S23
function qs=s23(v)
  qs = qsat(round(v*8388608),-8388608,8388607);
endfunction
# Quantise and saturate [B,A] to ref val r, with min=l max=h
function [Bq,Aq]=quantsat(B,A,r,l,h)
  Bq=B;
  Aq=A;
  for i=1:1:length(A)
    Aq(i) = qsat(round(A(i)*r),l,h)/r;
  end
  for i=1:1:length(B)
    Bq(i) = qsat(round(B(i)*r),l,h)/r;
  end
endfunction
