Class {
	#name : #PicoSmTestPatientIsSource,
	#superclass : #PicoSmTest,
	#category : #'Smada-Sm Example'
}

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
