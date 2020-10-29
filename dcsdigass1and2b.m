%% Energy dissipation senario 
 
clc;
clear all;
close all;
 
t = [0:.1:2*pi];
smax =  1500;
smin = 0.8;
s = smin + (smax-smin)*rand(1,length(t));
figure(1)
subplot(5,1,1)
plot(t, s)
title('Input Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
grid

subplot(5,1,2)
stem(t,s)
title('sampled Signal');
ylabel('Amplitude--->');
xlabel('Time--->');

%  Quantization Process

 vmax=1500;
 vmin=0.8;
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
 subplot(5,1,3);
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
 subplot(5,1,4); grid on;
 stairs(coded);     % Display the encoded signal
axis([0 100 -2 3]);  title('Encoded Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
 
 %   Demodulation Of PCM signal
 
 qunt=reshape(coded,8,length(coded)/8);
 index=bi2de(qunt','left-msb');      % Getback the index in decimal form
 q=del*index+vmin+(del/2);           % getback Quantized values
 subplot(5,1,5); grid on;
 plot(t,q);                          % Plot Demodulated signal
 axis([0 7 0.8 1511])
 title('Demodulated Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
 
partition = [0.8:.2:1500];

codebook = [0.5:.2:1500]; % Codebook length must be equal to the number of partition intervals

%quantiz Produce a quantization index and a quantized output value.
[index,quants] = quantiz(s,partition,codebook);

figure(2)
subplot(3,1,1)
plot(t, s)
xlabel('Time')
ylabel('Amplitude')
title('Decoded Quantized signal');
grid

subplot(3,1,2)
plot(t,s,'x',t,quants,'.')
title('Quantization of energy dissipated wave')
xlabel('Time')
ylabel('Amplitude')
legend('Original sampled wave','Quantized wave');
axis([0 7 0.8 1555])

% There is no decode quantizer function in this toolbox. 
% The decode computation can be done using the command Y = CODEBOOK(INDX+1).

dq=codebook(index+1);
subplot(3,1,3)
plot(t,dq)
axis([0 7 0.8 1555]);
xlabel('Time')
ylabel('Amplitude')
title('Decoded Quantized signal');