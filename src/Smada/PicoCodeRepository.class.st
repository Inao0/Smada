"
This class is to keep the methods of the pico core classes.

"
Class {
	#name : #PicoCodeRepository,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'color',
		'x',
		'y'
	],
	#category : #'Smada-CoreCodeRepository'
}

{ #category : #'environment access' }
PicoCodeRepository >> picoClassNamed: aName [ 
	
	^ PicoBlop giveClassNamed: aName
]
