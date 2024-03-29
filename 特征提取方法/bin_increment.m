function [ out ] = bin_increment( signal )
% Bins EMG signal incrementally creating overlapped segments of 100ms

t = .0005; % Sample frequency 2000 Hz = 1 sample/.5ms
inc = 50; % Shift after each bin
frame_length = .1; % Frame length in ms
n = frame_length/t;
frames = length(signal)/inc - n/inc;
out = zeros(frames,n);
for k = 0:(frames-1)
        %out(:,k+1) = signal((k*inc):(k*inc+n)); %和我的实验方法是一样的，窗口长度100ms，增量长度50ms
        out(k+1,:) = signal((k*inc+1):(k*inc+n),:);
end

end

