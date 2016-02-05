package box

class MainTagLib {
    static defaultEncodeAs = [taglib: 'none']
    //static encodeAsForTags = [datetimePicker: [taglib:'none'], selectize: [taglib: 'none'], slink: [taglib: 'none']]

    def grailsApplication
    def securityService

    def slink = {attrs, body ->
		def controller = attrs.controller ?: pageScope.controllerName
		def action = attrs.action
		if(securityService.checkLinkAccess(controller, action)){
			out << g.link(attrs, body)
		}else{
			out << (attrs.appear ? body() : '')
		}
	}

	def sif = {	attrs, body ->
		def controller = attrs.controller ?: pageScope.controllerName
		def action = attrs.action
		if(securityService.checkLinkAccess(controller, action)){
			out << body()
		}	
	}

	def datetimePicker = {attrs, body ->
		def format = grailsApplication.config.datetimepicker.format.datetime
		def icon = "glyphicon-calendar"
		if(attrs.precision){
			if(attrs.precision == 'date'){
				format = grailsApplication.config.datetimepicker.format.date
			}else if(attrs.precision == 'time'){
				format = grailsApplication.config.datetimepicker.format.time
				icon = "glyphicon-time"
			}
		}
		def pickerId = attrs.id ?: "dtp_${attrs.name - '.'}"
		out << """
		<div class='input-group datetimepicker date' id='${pickerId}'>
			${g.textField('class': 'form-control', name: attrs.name, value: joda.format(value: attrs.value), placeholder: attrs.placeholder)}
			<span class="input-group-addon"><span class="glyphicon ${icon}"></span></span>
		</div>
		<script type="text/javascript">
		 	\$(function () {
				\$('#${pickerId}').datetimepicker({
					format: '${format}'
				});		
			});
		</script>	 
		"""
	}

	def selectize = {attrs, body ->
		def pickerId = attrs.id ?: "dtp_${attrs.name - '.'}"
		attrs.id = pickerId
		out << g.select(attrs, body)
		out << """
		<script type="text/javascript">
		 	\$(function () {
				\$('#${pickerId}').selectize(${attrs.selectizeOptions ?: ''});
			});
		</script>
		"""
	}		
}
