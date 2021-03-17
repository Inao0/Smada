Class {
	#name : #PicoSmTestPatientIsSource,
	#superclass : #PicoTest,
	#instVars : [
		'picoClass',
		'picoObject',
		'sourceClass',
		'doctorClass',
		'patientClass',
		'medicalRecordClass',
		'noteClass',
		'stringClass',
		'socialSecurityNumberClass'
	],
	#category : #'Smada-Sm Example'
}

{ #category : #running }
PicoSmTestPatientIsSource >> defineDoctor [

	
	"now we pay attention to really use the non abstract metaclass"
	doctorClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmDoctor.
			#SmSource.
			#(name)}.
]

{ #category : #running }
PicoSmTestPatientIsSource >> defineMedicalRecord [

	
	"now we pay attention to really use the non abstract metaclass"
	medicalRecordClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmMedicalRecord.
			#PicoObject.
			#(notes address patient)}.
]

{ #category : #running }
PicoSmTestPatientIsSource >> defineNote [
	
	"now we pay attention to really use the non abstract metaclass"
	noteClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmNote.
			#PicoObject.
			#(contentHistory)}.
]

{ #category : #running }
PicoSmTestPatientIsSource >> definePatient [

	
	"now we pay attention to really use the non abstract metaclass"
	patientClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmPatient.
			#SmSource.
			#(name)}.
]

{ #category : #running }
PicoSmTestPatientIsSource >> defineSocialSecurityNumber [

	socialSecurityNumberClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmSocialSecurityNumber.
			#PicoObject.
			#(number)}.
]

{ #category : #running }
PicoSmTestPatientIsSource >> defineSource [

	
	"now we pay attention to really use the non abstract metaclass"
	sourceClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmSource.
			#PicoObject.
			#(id createdData)}.
]

{ #category : #running }
PicoSmTestPatientIsSource >> defineString [
	
	"now we pay attention to really use the non abstract metaclass"
	stringClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmString.
			#PicoObject.
			#(content)}.
]

{ #category : #running }
PicoSmTestPatientIsSource >> setUp [ 
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
	self defineSocialSecurityNumber.

]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testClassValidityInitialization [

	self assert: (picoClass send: #isValid).  
]

{ #category : #'test - basics' }
PicoSmTestPatientIsSource >> testDoctorNameAndIdSetAndGet [

	| s1 |
	s1 := doctorClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testInvalidSourceCreateInvalidData [
	|source obj|
	source := sourceClass send: #new.
	source send: #invalidate.
	self assert: (source send: #isValid) equals: false.  
	
	obj := source create: #PicoObject with: {}.
	self assert: (source send: #isValid) equals: false.

]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testInvalidationHighLevel [
	|obj|
	obj := picoObject send: #new.
	self assert: (obj send: #isValid).  
	
	obj send: #invalidate.
   self assert: (obj send: #isValid) equals: false.  
]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testInvalidationLowLevel [
	|obj|
	obj := picoObject send: #new.
	self assert: (obj send: #isValid).  
	
	obj invalidate.
   self assert: (obj send: #isValid) equals: false.  
]

{ #category : #'test - basics' }
PicoSmTestPatientIsSource >> testMedicalRecord [

	| m1 |
	m1 := medicalRecordClass send: #new.
	self assert: (m1 send: #notes) class equals: OrderedCollection
	
]

{ #category : #'test - basics' }
PicoSmTestPatientIsSource >> testMedicalRecordIsCreatedByAPatientAndInvalidation [

	
	| p1 parm m1 m2|
	"Creation of a Patient"
	p1 := patientClass send: #new.
	p1 send: #name:  withArguments: { 'Dupond' }.

	"Check initialization of the validity to true"
	self assert: (p1 send: #isValid).

	"Creation of the medicalRecord by the patient p1"
	parm := IdentityDictionary new.
	parm at: #address put: 'Belgique'.
	parm at: #patient put: p1.
	m1 := p1 create: #SmMedicalRecord with: parm.
	
	"Check that the owner is properly set"
	self assert: (m1 send: #owner) equals: p1.
	"Check that the medicalRecord is valid"
	self assert: (m1 send: #isValid).
	
	"Invalidating the patient source"
	p1 send: #invalidate.

	"Check that both patient and the medicalRecord are invalid"
	self assert: (p1 send: #isValid) equals: false.
	self assert: (m1 send: #isValid) equals: false.

	"Patient creates a new medicalRecord"
	m2 := p1 create: #SmMedicalRecord with: parm.
	"Check that patient invalidity has propagated to the new medical record"
	self assert: (m2 send: #isValid) equals: false.
	
]

{ #category : #'test - basics' }
PicoSmTestPatientIsSource >> testMedicalRecordIsCreatedByAPatientLowLevel [
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
PicoSmTestPatientIsSource >> testNote [

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
PicoSmTestPatientIsSource >> testNoteContentHistoryInitialisation [

	|note |
	note := noteClass send: #new.
	self assert: (note send: #contentHistory) class equals: OrderedCollection
	
]

{ #category : #'test - notes' }
PicoSmTestPatientIsSource >> testNoteModification [

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

{ #category : #'test - notes' }
PicoSmTestPatientIsSource >> testNoteModificationAndPartialInvalidation [

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
	
	doctor2 send: #invalidate.
	self assert: ((note send: #content) send: #content) equals: 'Grippe'.
	self assert: (note send: #owner) equals: doctor.
		
]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testPicoObjectClassValidityInitialization [

	self assert: (picoObject  send: #isValid).  
]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testSourceClassValidityInitialization [

	self assert: (sourceClass send: #isValid).  
]

{ #category : #'test - basics' }
PicoSmTestPatientIsSource >> testSourceIdSetAndGet [

	| s1 |
	s1 := sourceClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testSourceInvalidationIsPropagating [
	|source obj2|
	source := sourceClass send: #new.
	self assert: (source send: #isValid).  
	
	
	source create: #PicoObject with: {}.
	obj2 := source create: #PicoObject with: {}.
	source create: #PicoObject with: {}.
	
	source send: #invalidate.

	self assert: (source send: #isValid) equals: false.
	self assert: (obj2 send: #isValid) equals: false.
	(source send: #createdData ) do: [ :item | item ifNotNil: [self assert: (item send: #isValid) equals: false.]].
]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testSourceValidityInitialization [
	|source|
	source := sourceClass send: #new.
	self assert: (source send: #isValid).  
]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testValidSourceCreateValidData [
	|source obj|
	source := sourceClass send: #new.
	self assert: (source send: #isValid).  
	
	obj := source create: #PicoObject with: {}.
	self assert: (source send: #isValid).

]

{ #category : #'test - validity' }
PicoSmTestPatientIsSource >> testValidityInitialization [
	|obj|
	obj := picoObject send: #new.
	self assert: (obj send: #isValid).  
]
