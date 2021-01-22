Class {
	#name : #PicoInstanceScope,
	#superclass : #CHInstanceScope,
	#category : #'Smada-Core'
}

{ #category : #accessing }
PicoInstanceScope >> definedVariables [
	
	^ receiver picoClass picoIVs
]

{ #category : #accessing }
PicoInstanceScope >> read: aString [
	
	^ self receiver valueOfInstanceVariable: aString
]

{ #category : #accessing }
PicoInstanceScope >> write: aString withValue: anInteger [ 
	
	self receiver setValueOfInstanceVariable: aString to: anInteger
]
