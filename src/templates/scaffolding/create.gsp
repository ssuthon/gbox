<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
	
    	<h3><g:message code="default.create.label" args="[entityName]" /></h3>

		<div id="create-${domainClass.propertyName}" class="content scaffold-create" role="main">
			<ul class="nav nav-pills">
			  <li role="presentation">
			  	<g:slink class="list" action="index"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> <g:message code="default.list.label" args="[entityName]" /></g:slink>
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
			<g:form class="form-horizontal" url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
				
					<g:render template="form"/>
				
				<div class="form-group panel-footer">
					<div class="col-sm-offset-2 col-sm-10"> 
			      		<g:submitButton name="create" class="save btn btn-primary" value="\${message(code: 'default.button.create.label', default: 'Create')}" />
			      	</div>
			  	</div>
			</g:form>
		</div>
		
	</body>
</html>
