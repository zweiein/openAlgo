function [ascR] = ascRange(price,Mult)

if nargin == 1
        Mult = 3;
end; %if

[O,H,L,C] = OHLCSplitter(price);

rows = size(price,1);
ascR = (3 + Mult * 2) * ones(rows,1);

pRange = pricerange([H,L]);

chk = NaN * ones(rows,6);
chk(2:end,1) = abs(O(2:end) - C(1:end-1));
chk(4:end,2) = abs(C(1:end-3) - C(4:end));
chk(:,3) = movAvg(pRange,10,10,0) * 2;
chk(:,4) = movAvg(pRange,10,10,0) * 4.6;
chk(1:9,3:4) = NaN;

chk(:,5) = slidefun(@max,9,chk(:,3),'backward');
chk(:,6) = slidefun(@max,6,chk(:,4),'backward');

ascR(chk(:,1) >= chk(:,5)) = 3;
ascR(chk(:,2) >= chk(:,6)) = 4;

end

