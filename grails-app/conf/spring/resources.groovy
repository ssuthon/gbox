import box.CustomMarshallerRegistrar

beans = {
	customMarshallerRegistrar(CustomMarshallerRegistrar){
		grailsApplication = ref('grailsApplication')
	}
}
