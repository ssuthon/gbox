<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		

		<h3><g:message code="default.edit.label" args="[entityName]" /></h3>
		<div id="edit-${domainClass.propertyName}" class="content scaffold-edit" role="main">
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
			<g:hasErrors bean="\${${propertyName}}">
			<ul class="errors" role="alert">
				<g:eachError bean="\${${propertyName}}" var="error">
				<li <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>><g:message error="\${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<hr>
			<g:form class="form-horizontal" url="[resource:${propertyName}, action:'update']" method="PUT" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
				<g:hiddenField name="version" value="\${${propertyName}?.version}" />
				
					<g:render template="form"/>
				<div class="form-group panel-footer">
					<div class="col-sm-offset-2 col-sm-10">
						<g:actionSubmit class="save btn btn-primary" action="update" value="\${message(code: 'default.button.update.label', default: 'Update')}" />
					</div>
			  	</div>
			</g:form>
		</div>
	</body>
</html>
