#include <stdio.h>

#include "some_array_thing.h"

int cmp_int( const void * a , const void * b)
{
	int ia = *(const int *) a;
	int ib = *(const int *) b;

	if (ia < ib)
	{
		return -1;
	}
	else if (ia > ib)
	{
		return 1;
	}
	return 0;
}

int main (int argc, char ** argv)
{
	printf("Hello, world.\n");

	stdlib_dynamic_type dynamic_int = {
		.sizeof_data = sizeof(int),
		.func_cmp = cmp_int
	};

	stdlib_dynamic_instance some_int_storage = {
		.instance_type = dynamic_int
	};

	int result = stdlib_dynamic_type_init(&some_int_storage);

	int * i1 = (int *)malloc(sizeof(int));
	*i1 = 5;

	int * i2 = (int *)malloc(sizeof(int));
	*i2 = 4;

	int * i3 = (int *)malloc(sizeof(int));
	*i3 = 7;

	stdlib_dynamic_type_add_entry(
		&some_int_storage,
		i1
	);

	stdlib_dynamic_type_add_entry(
		&some_int_storage,
		i2
	);

	stdlib_dynamic_type_add_entry(
		&some_int_storage,
		i3
	);

	stdlib_dynamic_instance_qsort(&some_int_storage);

	printf("Our storage:\n");
	int counter;
	for (counter = 0 ; counter < some_int_storage.storage.nmemb; counter ++)
	{
		printf("Counter: %d\tValue: %d\n",
			counter,
			* (int *)(
				some_int_storage.storage.data
				+ counter * some_int_storage.instance_type.sizeof_data
			)
		);
	}

	printf("\nOur original values:\n");
	printf("i1: %d\n", *i1);
	printf("i2: %d\n", *i2);
	printf("i3: %d\n", *i3);	
	return 0;
}

