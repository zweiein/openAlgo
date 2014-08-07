function [ pRange ] = pricerange(price)
%PRICERANGE returns the absolute value difference between two vectors
%
%   INPUTS:     prices          An array of price in the form [H | L]     
%
%	OUTPUTS:	diff			PRICERANGE vector
%
%	PRICERANGE(PRICE)			Returns a 1 dimensional vector of the 'pricerange.m' function.

if size(price,2) ~= 2
    error('PRICERANGE:improperInputs', ...
        'PRICERANGE returns the aboslute value difference between 2 vectors. Supply price data in the form H | L as input. Exiting.');
end; %if

pRange = abs(price(:,1)-price(:,2));

