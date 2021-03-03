Class {
	#name : #PicoSmTest,
	#superclass : #PicoTest,
	#instVars : [
		'picoClass',
		'picoObject',
		'sourceClass',
		'doctorClass',
		'patientClass',
		'medicalRecordClass',
		'noteClass',
		'stringClass'
	],
	#category : #'Smada-Sm Example'
}

{ #category : #running }
PicoSmTest >> defineDoctor [

	
	"now we pay attention to really use the non abstract metaclass"
	doctorClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmDoctor.
			#SmSource.
			#(name)}.
]

{ #category : #running }
PicoSmTest >> defineMedicalRecord [

	
	"now we pay attention to really use the non abstract metaclass"
	medicalRecordClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmMedicalRecord.
			#PicoObject.
			#(notes address patient)}.
]

{ #category : #running }
PicoSmTest >> defineNote [
	
	"now we pay attention to really use the non abstract metaclass"
	noteClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmNote.
			#PicoObject.
			#(contentHistory)}.
]

{ #category : #running }
PicoSmTest >> definePatient [

	
	"now we pay attention to really use the non abstract metaclass"
	patientClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmPatient.
			#PicoObject.
			#(name)}.
]

{ #category : #running }
PicoSmTest >> defineSource [

	
	"now we pay attention to really use the non abstract metaclass"
	sourceClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmSource.
			#PicoObject.
			#(id createdData)}.
]

{ #category : #running }
PicoSmTest >> defineString [
	
	"now we pay attention to really use the non abstract metaclass"
	stringClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmString.
			#PicoObject.
			#(content)}.
]

{ #category : #running }
PicoSmTest >> setUp [ 
	super setUp.
	PicoBlop bootstrap.
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	picoObject := PicoBlop giveClassNamed: #PicoObject.
	
	self defineSource.
	self definePatient.
	self defineDoctor.
	self defineString.
	self defineNote.
	self defineMedicalRecord.

]

{ #category : #'test - validity' }
PicoSmTest >> testClassValidityInitialization [

	self assert: (picoClass send: #isValid).  
]

{ #category : #'test - basics' }
PicoSmTest >> testDoctorNameAndIdSetAndGet [

	| s1 |
	s1 := doctorClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]

{ #category : #'test - validity' }
PicoSmTest >> testInvalidationHighLevel [
	|obj|
	obj := picoObject send: #new.
	self assert: (obj send: #isValid).  
	
	obj send: #invalidate.
   self assert: (obj send: #isValid) equals: false.  
]

{ #category : #'test - validity' }
PicoSmTest >> testInvalidationLowLevel [
	|obj|
	obj := picoObject send: #new.
	self assert: (obj send: #isValid).  
	
	obj invalidate.
   self assert: (obj send: #isValid) equals: false.  
]

{ #category : #'test - basics' }
PicoSmTest >> testMedicalRecord [

	| m1 |
	m1 := medicalRecordClass send: #new.
	self assert: (m1 send: #notes) class equals: OrderedCollection
	
]

{ #category : #'test - basics' }
PicoSmTest >> testMedicalRecordIsCreatedByAPatient [

	| p1 parm m1 |
	p1 := patientClass send: #new.
	p1 send: #name:  withArguments: { 'Dupond' }.
	parm := IdentityDictionary new.
	parm at: #address put: 'Belgique'.
	parm at: #patient put: p1.
	
	m1 := p1 create: #SmMedicalRecord with: parm.
	
	self assert: (m1 send: #owner) equals: p1
	
]

{ #category : #'test - basics' }
PicoSmTest >> testMedicalRecordIsCreatedByAPatientLowLevel [
	| p m1 |
	p := patientClass send: #new.
	m1 := medicalRecordClass send: #new.
	m1 privateOwnedBySetter: p.

	"the following test shows that owner is accessible in the language (high level)"
	self assert: (m1 send: #owner) equals: p.
	
	"the following test shows that owner is primitive potentially not accessible from the language (high level)"
	self assert: m1 picoOwner equals: p
]

{ #category : #'test - notes' }
PicoSmTest >> testNote [

	|note doctor|
	note := noteClass send: #new.
	doctor := doctorClass send: #new.
	doctor send: #id: withArguments: { #Doctor1}.

	note send: #content:by: withArguments: {'Grippe' . doctor}.
	self assert: (note send: #contentHistory) size equals: 1.
	self assert: ((note send: #content) send: #content) equals: 'Grippe'.
	self assert: ((note send: #content) send: #owner) equals: doctor.
	
]

{ #category : #'test - notes' }
PicoSmTest >> testNoteContentHistoryInitialisation [

	|note |
	note := noteClass send: #new.
	self assert: (note send: #contentHistory) class equals: OrderedCollection
	
]

{ #category : #'test - notes' }
PicoSmTest >> testNoteModification [

	|note doctor doctor2|
	
	note := noteClass send: #new.
	doctor := doctorClass send: #new.
	doctor2 := doctorClass send: #new.
	doctor send: #id: withArguments: { #Doctor1}.
	doctor2 send: #id: withArguments: { #Doctor2}.

	note send: #content:by: withArguments: {'Grippe' . doctor}.
	self assert: (note send: #owner) equals: doctor.
	note send: #content:by: withArguments: {'Grippe H1N1' . doctor2}.
	
	self assert: (note send: #contentHistory) size equals: 2.
	self assert: ((note send: #content) send: #content) equals: 'Grippe H1N1'.
	self assert: ((note send: #content) send: #owner) equals: doctor2. 
	self assert: (note send: #owner) equals: doctor2.
	
	self assert: ((note send: #contentHistory) first send: #content) equals: 'Grippe'.
	self assert: ((note send: #contentHistory) first send: #owner) equals: doctor. 
]

{ #category : #'test - validity' }
PicoSmTest >> testPicoObjectClassValidityInitialization [

	self assert: (picoObject  send: #isValid).  
]

{ #category : #'test - validity' }
PicoSmTest >> testSourceClassValidityInitialization [

	self assert: (sourceClass send: #isValid).  
]

{ #category : #'test - basics' }
PicoSmTest >> testSourceIdSetAndGet [

	| s1 |
	s1 := sourceClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]

{ #category : #'test - validity' }
PicoSmTest >> testSourceValidityInitialization [
	|source|
	source := sourceClass send: #new.
	self assert: (source send: #isValid).  
]

{ #category : #'test - validity' }
PicoSmTest >> testValidityInitialization [
	|obj|
	obj := picoObject send: #new.
	self assert: (obj send: #isValid).  
]
