clc;
fs=input("Enter the sampling frequency of the signal: ");
startTime=input("Enter the start of time scale: ");
endTime=input("Enter the end of time scale: ");
breakPointCount=input("Enter the number of breaking points: ");

breakPointPos=ones(1,breakPointCount); %set array of size breakPointCount to hold breakpoint positions
for i=1:breakPointCount
    breakPointPos(i)=input(sprintf("Enter the position of break point %d: ",i));
end
signalSTime=startTime;
signalETime=startTime;
totSignal=[];


for i=1:breakPointCount+1 %there are n+1 regions for n break points
    if (breakPointCount==0) %no break points
        signalSTime=startTime;
        signalETime=endTime;
    else if (i==breakPointCount+1) %last region
        signalSTime=breakPointPos(i-1);
        signalETime=endTime;
    else if (i==1) %first region
        signalSTime=startTime;
        signalETime=breakPointPos(i);
    else
        signalSTime=breakPointPos(i-1);
        signalETime=breakPointPos(i);
    end        
    end
    end
    fprintf('Choose signal from time %d to %d:\n',signalSTime,signalETime);
    signalType=input(" 1. DC Signal\n 2. Ramp Signal\n 3. General Order Polynomial\n 4. Exponential Signal\n 5. Sinusoidal Signal\n");
    span=abs(signalSTime-signalETime);
    switch(signalType)
        case 1
            dcAmp=input("Enter amplitude of DC signal: ");
            t1=linspace(signalSTime,signalETime,span*fs);
            signal=dcAmp*ones(1,span*fs);
            
        case 2
            slope=input("Enter slope of Ramp signal: ");
            intercept=input("Enter intercept of Ramp signal: ");
            t2=linspace(signalSTime,signalETime,span*fs);
            signal=slope*t2+intercept;
        case 3
            power=input("Enter highest power of polynomial: ");
            coeff=[];
            for n=1:power+1
                fprintf("Please enter coefficient of x power of %d:\n",n-1);
                coeff(n)=input(' ');
            end
            t3=linspace(signalSTime,signalETime,span*fs);
            signal=0;
            for j=1:power+1
            signal=signal+coeff(j)*t3.^(j-1);
            end
        case 4
            expAmp=input("Enter amplitude of exponential signal: ");
            exponent=input("Enter exponent of signal: ");
            t4=linspace(signalSTime,signalETime,span*fs);
            signal=expAmp*exp(exponent*t4);
        case 5
            sinAmp=input("Enter amplitude of sinusoidal signal: ");
            sinFreq=input("Enter frequency of signal: ");
            phase=input("Enter phase shift of signal: ");
            t5=linspace(signalSTime,signalETime,span*fs);
            signal=sinAmp*sin(2*pi*sinFreq*t5+phase);         
    end
    totSignal=[totSignal signal];
end
totTime=linspace(startTime,endTime,fs*abs(endTime-startTime));
plot(totTime,totSignal);
grid on
flag=1 %keeps asking user to perform operations until exit
while(flag)
fprintf("Choose the operation you want to perform on the signal:\n");
op=input(" 1. Amplitude Scaling\n 2. Time Reversal\n 3. Time Shift\n 4. Expansion\n 5. Compression\n 6. None\n ");

switch(op)
    case 1
        scale=input("Enter the Amplitude Scale value: "); 
        totSignal=scale.*totSignal;
    case 2
        totTime=-totTime;
    case 3
        shift=input("Enter the signed shift value: ");
        totTime=totTime-shift;
    case 4
        expandVal=input("Enter the expanding value: ");
        totTime=totTime*expandVal;
    case 5
        compVal=input("Enter the compressing value: ");
        totTime=totTime/compVal;
    case 6
        flag=0;
        
end
figure;
plot(totTime,totSignal);
grid on
end
    