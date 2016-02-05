<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
 
		<h3><g:message code="default.show.label" args="[entityName]" /></h3>

		<div id="show-${domainClass.propertyName}" class="content scaffold-show" role="main">
			<ul class="nav nav-pills">
			  <li role="presentation">
			  	<g:slink class="list" action="index"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> <g:message code="default.list.label" args="[entityName]" /></g:slink>
			  </li>
			  <li role="presentation">
			  	<g:slink class="create" action="create"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <g:message code="default.new.label" args="[entityName]" /></g:slink>
			  </li>
			</ul>
			<g:if test="\${flash.message}">
			<div class="alert alert-info" role="alert">\${flash.message}</div>
			</g:if>
			<hr>
			<form class="form-horizontal">
			<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
				allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
				props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
				Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
				props.each { p -> %>
				<g:if test="\${${propertyName}?.${p.name}}">
				<div class="form-group">
					<label for="${p.name}" id="${p.name}-label" class="col-sm-2 control-label"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
					<%  if (p.isEnum()) { %>
						<div class="col-sm-4"><p class="form-control-static"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></p></div>
					<%  } else if (p.oneToMany || p.manyToMany) { %>
						<g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
						<div class="col-sm-4"><p class="form-control-static"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></p></div>
						</g:each>
					<%  } else if (p.manyToOne || p.oneToOne) { %>
						<div class="col-sm-4"><p class="form-control-static"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></p></div>
					<%  } else if (p.type == Boolean || p.type == boolean) { %>
						<div class="col-sm-4"><p class="form-control-static"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></p></div>
					<%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
						<div class="col-sm-4"><p class="form-control-static"><g:formatDate date="\${${propertyName}?.${p.name}}" /></p></div>
					<%  } else if (!p.type.isArray()) { %>
						<div class="col-sm-4"><p class="form-control-static"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></p></div>
					<%  } %>
				</div>
				</g:if>
			<%  } %>
			</form>
			<g:form class="form-horizontal" url="[resource:${propertyName}, action:'delete']" method="DELETE">
				<div class="form-group panel-footer">
					<div class="col-sm-offset-2 col-sm-10">
					<g:actionSubmit class="edit btn btn-default" action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit')}"/>
					<g:actionSubmit class="save btn btn-danger" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</div>
			</g:form>
		</div>
		
	</body>
</html>
