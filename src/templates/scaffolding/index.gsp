<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		  	<h3><g:message code="default.list.label" args="[entityName]" /></h3>
		 
		  
		    <div id="list-${domainClass.propertyName}" class="content scaffold-list" role="main">
		    	<ul class="nav nav-pills">
				  <li role="presentation">
				  	<g:slink class="create" action="create"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <g:message code="default.new.label" args="[entityName]" /></g:slink>
				  </li>
				</ul>
				<g:if test="\${flash.message}">
					<div class="alert alert-info" role="alert">\${flash.message}</div>
				</g:if>
				<br/>
				<!--div class="panel panel-default">					
					<div class="panel-heading">
						<h4 class="panel-title">
							<g:message code="default.filter.label" default="Filter"/>						
						</h4>

					</div>
				 	<div class="panel-body">
				 		<g:form class="form" action="index" method="get">
				 			<div class="row">

				 				<div class="col-sm-2">
				 						<input type="text" class="form-control" name="f_title" placeholder="\${message(code: '${domainClass.propertyName}.title.label', default: 'Title')}"
				 						value="\${params.f_title}">
				 				</div>

				 				<div class="col-sm-1">
				 					<button class="btn btn-default" type="submit">
											<span class="glyphicon glyphicon-search"></span>
									</button>
				 				</div>
				 			</div>				 			
				 		</g:form>
					</div>
				</div-->
				<table class="table table-hover">
				<thead>
						<tr>
						<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
							allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
							props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
							Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
							props.eachWithIndex { p, i ->
								if (i < 6) {
									if (p.isAssociation()) { %>
							<th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
						<%      } else { %>
							<g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
						<%  }   }   } %>
						</tr>
					</thead>
					<tbody>
					<g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
						<tr class="\${(i % 2) == 0 ? 'even' : 'odd'}">
						<%  props.eachWithIndex { p, i ->
								if (i == 0) { %>
							<td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
						<%      } else if (i < 6) {
									if (p.type == Boolean || p.type == boolean) { %>
							<td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
						<%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
							<td><g:formatDate date="\${${propertyName}.${p.name}}" /></td>
						<%          } else if (p.type == org.joda.time.LocalDate || p.type == org.joda.time.LocalDateTime) { %>
							<td><joda:format value="\${${propertyName}.${p.name}}"/></td>
						<%          } else { %>
							<td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
						<%  }   }   } %>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pull-right" style="margin: 0;">
					<g:paginate total="\${${propertyName}Count ?: 0}" params="\${params.findAll{ k, v-> k.startsWith('f_') }}"/>
				</div>
			</div>
		 
		
	</body>
</html>
