Class {
	#name : #PicoAbstractPointCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'Smada-Metaclass Example'
}

{ #category : #displaying }
PicoAbstractPointCode >> display [ 
	
	^ 'I am a ', self picoClassName asString, ' with (', (self send: #x) asString, ' , ' , (self send: #y ) asString, ')'
]
