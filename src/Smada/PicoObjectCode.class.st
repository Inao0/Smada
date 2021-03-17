"
error: arrayOfArguments

	('Error ', arrayOfArguments first) trace.
	^ 'Error ', arrayOfArguments first
"
Class {
	#name : #PicoObjectCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'Smada-CoreCodeRepository'
}

{ #category : #'error handling' }
PicoObjectCode >> error: arrayOfArguments [
	| msg |
	msg := ('Error: message ', arrayOfArguments first, ' not found in class ', self picoClassId).
	msg trace.
	^ msg
]

{ #category : #'sm data' }
PicoObjectCode >> initialize [
	super initialize.
	self initializeValidity.
]

{ #category : #'error handling' }
PicoObjectCode >> introspectReadVariable: aSymbol [

	^ self valueOfInstanceVariable: aSymbol
]

{ #category : #'error handling' }
PicoObjectCode >> introspectWriteVariable: aSymbol value: aValue [

	self at: (self offsetFromObjectOfInstanceVariable: aSymbol) put: aValue
]

{ #category : #'sm data' }
PicoObjectCode >> invalidate [
	self invalidate.
]

{ #category : #testing }
PicoObjectCode >> isClass [

	^ false
]

{ #category : #testing }
PicoObjectCode >> isMetaclass [

	^ false
]

{ #category : #'sm data' }
PicoObjectCode >> isSource [

	^ false
]

{ #category : #'sm data' }
PicoObjectCode >> isValid [

	^ self picoValid
]

{ #category : #testing }
PicoObjectCode >> klass [

	^ self picoClass 
]

{ #category : #'sm data' }
PicoObjectCode >> owner [

	^ self picoOwner 
]

{ #category : #testing }
PicoObjectCode >> picoClass [

	^ self picoClass 
]
