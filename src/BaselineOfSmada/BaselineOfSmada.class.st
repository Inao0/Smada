Class {
	#name : #BaselineOfSmada,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmada
}

{ #category : #baselines }
BaselineOfSmada >> baseline: spec [
	<baseline>
	spec
		baseline: 'ContainersPropertyEnvironment'
		with: [ spec repository: 'github://Ducasse/Containers-PropertyEnvironment' ].
	spec
		baseline: 'Champollion'
		with: [ spec repository: 'github://Ducasse/Champollion' ].	
	spec
		for: #pharo
		do: [ 
			spec
				package: 'Smada' with: [ spec requires: #('ContainersPropertyEnvironment' 'Champollion') ] ]
]
