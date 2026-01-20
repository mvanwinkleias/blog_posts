# stdlib fun

I'm looking at the code for grepcidr and it uses stdlib's qsort and
bsearch functions on IPv4 addresses and IPv6 addresses.

I was wondering how, if you can't do "pointer arithmetic" on void pointers
how qsort can alter the values at indeces in a void pointer array.

I didn't dig in very far, but after reading some things I assumed
that it just casted the void * to a char * so that you could do math on it.

This allows for you to have a sort of generic backend data type that
then can have space be dynamically allocated to it, and can be used on
(say) qsort and bsearch.

grepcidr uses a set of global variables for the groups of v4 and v6 addresses
and I didn't want to have to write the same memory allocation logic more
than once.

I thiiiiink I can also sub in their search and cmp functions with what I've
done.
