Class {
	#name : #PicoGlobalScope,
	#superclass : #CHGlobalScope,
	#category : #'Smada-Core'
}

{ #category : #'meta-object-protocol' }
PicoGlobalScope >> read: aString [ 
	self halt.
	"unused for now."
	^ PicoBlop giveClassNamed: aString
]
