package box

import grails.converters.JSON

class CustomMarshallerRegistrar{

	def registerMarshallers(){
		
	}

	private prep(obj, attrs){
		def map = [:]
		if(obj){
			attrs.each { attr ->
				map[attr] = obj."$attr"
			}
		}		
		map
	}
}