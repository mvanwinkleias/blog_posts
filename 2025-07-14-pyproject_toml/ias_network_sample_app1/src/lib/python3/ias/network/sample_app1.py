class sample_app1:
    def run(self):
        self.hello()

    def hello(self): # pylint: disable=no-self-use
        """ This says hello. """
        print("Hello from " + __name__)

def run():
	app = sample_app1()
	app.run()

if __name__ == "__main__":
	run()
