"
We could :
- Integrate Pharo String as we did for OrderedCollection. Then initialise the content of the SmString to an empty string.
- Keep working like we do now and have content being filled with byteString when initialised. The way we set up the class, it could technically be described as a SmartContainer has we could put anything into the content variable.

"
Class {
	#name : #SmStringCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#instVars : [
		'content'
	],
	#category : #'Smada-Sm Example'
}

{ #category : #accessing }
SmStringCode >> content [
	^ content
]

{ #category : #accessing }
SmStringCode >> content: anObject modifiedBy: aSource [

	self restrictedModificationOf: #content to: anObject  by: aSource
]
