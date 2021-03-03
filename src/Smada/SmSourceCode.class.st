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
	createdData := WeakOrderedCollection new.
]

{ #category : #initialization }
SmSourceCode >> isSource [
	^ true
]
