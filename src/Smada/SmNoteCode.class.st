Class {
	#name : #SmNoteCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#instVars : [
		'contentHistory'
	],
	#category : #'Smada-Sm Example'
}

{ #category : #accessing }
SmNoteCode >> content [
	^contentHistory last

]

{ #category : #accessing }
SmNoteCode >> content: newContent by: aSource [
	contentHistory add: (aSource create: #SmString with: {#content -> newContent} asDictionary ). 

]

{ #category : #accessing }
SmNoteCode >> contentHistory [
	^ contentHistory

]

{ #category : #initialization }
SmNoteCode >> initialize [
	super send: #initialize.
	contentHistory := OrderedCollection new.
]

{ #category : #accessing }
SmNoteCode >> owner [
	"This overides the (primitive?) owner we defined in PicoSmTest and return the owner of the last version. This could also be implemented by having a 'currentOwner' method. I chose to do it that way for ease of manipulation, similar to content, that return the last version only"	
		^ (contentHistory last) send: #owner.
		"Is is the rigth level for using send: ?"

]
