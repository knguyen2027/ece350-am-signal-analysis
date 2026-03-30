%350 lab 11

%1-1
t = 0:0.01:10.23;

%1-2
x1 = (my_unit_step(t,1) - my_unit_step(t,2)) + ...
     (my_unit_step(t,3) - my_unit_step(t,4)) + ...
     (my_unit_step(t,5) - my_unit_step(t,6)) + ...
     (my_unit_step(t,7) - my_unit_step(t,8)) + ...
     (my_unit_step(t,9) - my_unit_step(t,10));

for i = 1:length(x1)
    if x1(i) == 0
        x1(i) = -1;
    end
end
%1-2
x2 = (my_unit_step(t,2) - my_unit_step(t,6));

for i = 1:length(x2)
    if x2(i) == 0
        x2(i) = -1;
    end
end

%1-3
figure;
hold on;
subplot(1,2,1);
plot(t, x1);
title('Signal x1(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

subplot(1,2,2);
hold on;
plot(t, x2);
title('Signal x2(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

%Part 2

%2-1
x1a = 2+x1;
x2a = 2+x2;

%2-2
figure;
hold on;
subplot(1,2,1);
plot(t, x1a);
title('Signal x1a(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

subplot(1,2,2);
hold on;
plot(t, x2a);
title('Signal x2a(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

%2-3
x1_mod = x1a.*cos(2*pi*15*t);

%2-4
x2_mod = x2a.*cos(2*pi*25*t);
%2-5
figure;
hold on;
subplot(2,1,1);
plot(t, x1_mod, 'r', 'LineWidth', 0.1);
title('Modulated Signal x1 mod(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

hold on;
subplot(2,1,2);
plot(t, x2_mod, 'b', 'LineWidth', 0.1);
title('Modulated Signal x2 mod(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

%2-6
Ts = t(2) - t(1);      % sample period (should be 0.01)
Fs = 1/Ts;             % sampling frequency  -> 100 Hz
N  = length(t); 

f = (-N/2:N/2-1) * (Fs/N);

% Nyquist stuff
f_nyquist = Fs/2;      % 50 Hz
nyquist_rate = 2*f_nyquist;

figure;
hold on;
subplot(2,1,1);
plot(f, abs(fft(x1_mod)), 'r', 'LineWidth', 0.1);
title('FFT of x1_mod (t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
hold off;

hold on;
subplot(2,1,2);
plot(f, abs(fft(x2_mod)), 'b', 'LineWidth', 0.1);
title('FFT of x2_mod (t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
hold off;

%Part3
%3-1
x_sum = x1_mod + x2_mod;

%3-2

figure;
hold on;
plot(f, abs(fft(x_sum)));
title('FFT of x_sum (t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
hold off;

%Part4

%4-1
Ts = t(2) - t(1);   % should be 0.01
Fs = 1/Ts;          % 100 Hz
Fn = Fs/2;          % Nyquist = 50 Hz

f1_low  = 12;   
f1_high = 18;     

W1 = [f1_low f1_high] / Fn;

[b1, a1] = butter(5, W1, 'bandpass');

%4-2
f2_low  = 22;   
f2_high = 28;     

W2 = [f2_low f2_high] / Fn;

[b2, a2] = butter(5, W2, 'bandpass');

%4-3
% Frequency responses
[h1, w1] = freqz(b1, a1);
[h2, w2] = freqz(b2, a2);

nf = Fn;   % Nyquist freq = 50 Hz

figure;
subplot(2,1,1);
plot(w1*nf/pi, abs(h1));
title('Band-pass Filter for x1 (around 15 Hz)');
xlabel('Frequency (Hz)');
ylabel('|H_1(f)|');
grid on;

subplot(2,1,2);
plot(w2*nf/pi, abs(h2));
title('Band-pass Filter for x2 (around 25 Hz)');
xlabel('Frequency (Hz)');
ylabel('|H_2(f)|');
grid on;

%4-4
x1_filt = filter(b1, a1, x1_mod);
x2_filt = filter(b2, a2, x2_mod);


%4-5
figure;
hold on;
subplot(2,1,1);
plot(f, abs(fft(x1_filt)), 'r', 'LineWidth', 0.1);
title('FFT of x1_filt (t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
hold off;

hold on;
subplot(2,1,2);
plot(f, abs(fft(x2_filt)), 'r', 'LineWidth', 0.1);
title('FFT of x2_filt (t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
hold off;

%4-6
figure;
hold on;
subplot(2,1,1);
plot(t, x1_filt, 'r', 'LineWidth', 0.1);
title('Filtered Signal x1_filt(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

hold on;
subplot(2,1,2);
plot(t, x2_filt, 'r', 'LineWidth', 0.1);
title('Filtered Signal x2_filt(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

%Part 5

%5-2
x1_rect = abs(x1_filt);
x2_rect = abs(x2_filt);

%5-3
[b3, a3] = butter(5, 0.1);
[b4, a4] = butter(5, 0.2);

%5-4
[h3, w3] = freqz(b3, a3);
[h4, w4] = freqz(b4, a4);

figure;
subplot(2,1,1);
plot(w3*nf/pi, abs(h3));
title('Low-pass Filter Frequency Response (x1 envelope detector)');
xlabel('Frequency (Hz)');
ylabel('|H_1(f)|');
grid on;

subplot(2,1,2);
plot(w4*nf/pi, abs(h4));
title('Low-pass Filter Frequency Response (x2 envelope detector)');
xlabel('Frequency (Hz)');
ylabel('|H_2(f)|');
grid on;

%5-5
x1_env = filtfilt(b3, a3, x1_rect);
x2_env = filtfilt(b4, a4, x2_rect);


figure;
subplot(2,1,1);
plot(t, x1_env, 'LineWidth', 1.2); hold on;
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Recovered Envelop for x1 (LPF output)');
hold off;

subplot(2,1,2);
plot(t, x2_env, 'LineWidth', 1.2); hold on;
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Recovered Envelop for x2 (LPF output)');
hold off;

%quiz
Fs = 1/(t(2)-t(1));
N  = length(sig_sum);
f  = (-N/2:N/2-1) * (Fs/N);
Sig = fftshift(fft(sig_sum));

figure; plot(f, abs(Sig)); grid on;
xlabel('Frequency (Hz)');
ylabel('|SIG(f)|');
title('FFT of given signal');


