Class {
	#name : #SmSourceCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#instVars : [
		'id',
		'createdData'
	],
	#category : #'Smada-Sm Example'
}

{ #category : #accessing }
SmSourceCode >> create: aPieceOfData [
	
	createdData add: aPieceOfData
]

{ #category : #accessing }
SmSourceCode >> createdData [
	
	^ createdData 
]

{ #category : #accessing }
SmSourceCode >> id [ 
	
	^ id
]

{ #category : #accessing }
SmSourceCode >> id: aSymbol [
	
	id := aSymbol
]

{ #category : #initialization }
SmSourceCode >> initialize [
	super send: #initialize.
	createdData := WeakOrderedCollection new.
]

{ #category : #initialization }
SmSourceCode >> invalidate [
   
   super send: #invalidate.
   self invalidateCollection: (self send: #createdData).
	" Following line, especially the 'do:', can not be interpreted by Champollion. Therefore I implemented a primitive in PicoBlop that can call Pharo's do:
	(self send: #createdData) do: [:each | each ifNotNil: [ each send: #invalidate]]."
		
]

{ #category : #initialization }
SmSourceCode >> isSource [
	^ true
]
