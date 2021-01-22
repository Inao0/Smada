Class {
	#name : #PicoAbstractClassCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'Smada-Metaclass Example'
}

{ #category : #'class behavior' }
PicoAbstractClassCode >> allocate [

	^ Error signal: 'The class ', self picoClassName asString, ' is abstract.'
]
