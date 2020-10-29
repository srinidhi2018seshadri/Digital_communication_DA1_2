%% Speed vs time senario %%

clc;
clear all;
close all;

t=[0 6 10 15 18 19 20 28 40 45 50 60 67 90 99 100 120];
s=[0 10 15 10 20 20 21 50 0 15 28 60 2 110 120 65 0 ];

subplot(4,1,1)
stem(t,s)

%  Quantization Process

 vmax=120;
 vmin=-vmax;
 del=(vmax-vmin)/256;
 part=vmin:del:vmax;        % level are between vmin and vmax with difference of del
 code=vmin-(del/2):del:vmax+(del/2);   % Contaion Quantized valuses 
 [ind,q]=quantiz(s,part,code);     % Quantization process
  % ind contain index number and q contain quantized  values
 l1=length(ind);
 l2=length(q);
  
 for i=1:l1
    if(ind(i)~=0)        % To make index as binary decimal so started from 0 to N
       ind(i)=ind(i)-1;
    end 
    i=i+1;
 end   
  for i=1:l2
     if(q(i)==vmin-(del/2))   % To make quantize value inbetween the levels
         q(i)=vmin+(del/2);
     end
 end    
 subplot(4,1,2);
 stem(q);grid on;     % Display the Quantize values
 title('Quantized Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
  
 %  Encoding Process
%  figure
 code=de2bi(ind,'left-msb');     % Cnvert the decimal to binary
 k=1;
for i=1:l1
    for j=1:8
        coded(k)=code(i,j);    % convert code matrix to a coded row vector
        j=j+1;
        k=k+1;
    end
    i=i+1;
end
 subplot(4,1,3); grid on;
 stairs(coded);     % Display the encoded signal
axis([0 100 -2 3]);  title('Encoded Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
 
 %   Demodulation Of PCM signal
 
 qunt=reshape(coded,8,length(coded)/8);
 index=bi2de(qunt','left-msb');      % Getback the index in decimal form
 q=del*index+vmin+(del/2);           % getback Quantized values
 subplot(4,1,4); grid on;
 stem(t,q);                          % Plot Demodulated signal
 title('Demodulated Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
 
 