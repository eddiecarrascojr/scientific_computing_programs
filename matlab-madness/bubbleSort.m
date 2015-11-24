function A = bubblesort(A)
%bubbleSort(A) A is a list of numbers, the bubble sort will swap
%the index values from increasing values.
    swap = true;
    i = numel(A);
    while(swap)
        swap = false;
        i = i - 1;
        for index = (1:i)
            if(A(index) > A(index+1))
                A([index index+1]) = A([index+1 index]); %swap
                swap = true;
            end %if
        end %for
    end %while
end %bubbleSort
