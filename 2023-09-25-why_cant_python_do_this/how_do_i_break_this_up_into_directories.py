#!/usr/bin/python3

class A:
	class B:
		class C:
			def c_hello(self):
				print("Hello, C")

print ("Hello")

c = A.B.C()

c.c_hello()

# Why the hell doesn't this work:
# class A.B.C:
#     def c_hello(self):
#         print ("Hello, C")

