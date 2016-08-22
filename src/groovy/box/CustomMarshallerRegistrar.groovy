package box

import grails.converters.JSON
import org.joda.time.*
import org.joda.time.format.DateTimeFormat

class CustomMarshallerRegistrar{
	def grailsApplication

	@javax.annotation.PostConstruct
	def registerMarshallers(){
		def localDateFormatter = DateTimeFormat.forPattern(grailsApplication.config.jodatime.format.org.joda.time.LocalDate)
		def localDateTimeFormatter = DateTimeFormat.forPattern(grailsApplication.config.jodatime.format.org.joda.time.LocalDateTime)		
		
		JSON.registerObjectMarshaller(LocalDate, 99){
			localDateFormatter.print(it)
		}

		JSON.registerObjectMarshaller(LocalDateTime, 99){
			localDateTimeFormatter.print(it)
		}
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