#include <stdlib.h>

typedef struct stdlib_dynamic_type
{
	size_t sizeof_data;
	int (*func_cmp)(const void *, const void *) ;
	int (*func_search)(const void *, const void *) ;
} stdlib_dynamic_type ;

typedef struct stdlib_dynamic_storage
{
	size_t capacity;
	size_t nmemb;
	void* data ;
} stdlib_dynamic_storage ;

typedef struct stdlib_dynamic_instance
{
	stdlib_dynamic_type instance_type ;
	stdlib_dynamic_storage storage ;
} stdlib_dynamic_instance ;

int stdlib_dynamic_type_init(
	struct stdlib_dynamic_instance *dyn
)
{
	dyn->storage.capacity = 64;
	dyn->storage.nmemb = 0;
	dyn->storage.data = (char *)malloc(
		dyn->storage.capacity
		* dyn->instance_type.sizeof_data
	);
}

int stdlib_dynamic_type_add_entry(
	struct stdlib_dynamic_instance *dyn,
	void* entry
)
{
	if (dyn->storage.capacity = dyn->storage.nmemb)
	{
		dyn->storage.capacity *= 2;
		void* ptr = realloc(
			dyn->storage.data,
			dyn->storage.capacity * dyn->instance_type.sizeof_data
		);
		
		if (ptr == NULL )
		{
			return 1;
		}
		
		dyn->storage.data = ptr;
	}
	
	* (char *)( dyn->storage.data + (
		dyn->storage.nmemb++ * dyn->instance_type.sizeof_data
	) ) = * (char *)entry ;
	
	return 0;
}

void stdlib_dynamic_instance_qsort(
	stdlib_dynamic_instance * dyn
)
{
	qsort(
		dyn->storage.data,
		dyn->storage.nmemb,
		dyn->instance_type.sizeof_data,
		dyn->instance_type.func_cmp
	);
}

void * stdlib_dynamic_instance_bsearch(
	void * key,
	stdlib_dynamic_instance * dyn 
)
{
	return bsearch(
		key,
		dyn->storage.data,
		dyn->storage.nmemb,
		dyn->instance_type.sizeof_data,
		dyn->instance_type.func_search
	);
}

