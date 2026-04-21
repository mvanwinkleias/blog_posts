
#define stdlib_dynamic_cmp_name(DYNAMIC_TYPE) cmp_dynamic_type_ ## DYNAMIC_TYPE
#define stdlib_dynamic_type_defs(DYNAMIC_TYPE) \
\
DYNAMIC_TYPE cmp_dynamic_type_ ## DYNAMIC_TYPE( const void * a , const void * b)\
{\
	DYNAMIC_TYPE ia = *(const DYNAMIC_TYPE *) a;\
	DYNAMIC_TYPE ib = *(const DYNAMIC_TYPE *) b;\
\
	if (ia < ib)\
	{\
		return -1;\
	}\
	else if (ia > ib)\
	{\
		return 1;\
	}\
	return 0;\
} \
stdlib_dynamic_type stdlib_dynamic_int = { \
.sizeof_data = sizeof(DYNAMIC_TYPE),\
.func_cmp = stdlib_dynamic_cmp_name(DYNAMIC_TYPE)\
};
