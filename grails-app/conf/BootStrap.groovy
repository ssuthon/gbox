import grails.util.Environment

class BootStrap {	
	def fixtureLoader
	def customMarshallerRegistrar

    def init = { servletContext ->

    	customMarshallerRegistrar.registerMarshallers()
    	
    	Environment.current.executeForCurrentEnvironment {
			development {
				fixtureLoader.load("dev")
			}
		}
    }
    def destroy = {
    }
}
