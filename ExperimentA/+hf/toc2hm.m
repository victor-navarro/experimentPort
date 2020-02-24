function string = toc2hm(ticPointer)
    theTime = toc(ticPointer);
    string = sprintf('%d:%d', floor(theTime/(60*60)), floor(rem(theTime,(60*60))/60));