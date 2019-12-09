function sq = quantize(x,l)
    % x : input signal
    % l : quantization level
    x = reshape(x,[],1);
    l = reshape(l,1,[]);
    dists = abs(x-l);
    [nI,I] = min(dists,[],2);
    sq = l(I);
end
