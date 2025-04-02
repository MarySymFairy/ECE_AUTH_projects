SELECT brain_regions.regionName, neurotransmitters.neurotransmitterName, activated_neurons.activationID, activated_neurons.duration, emitted_neurotransmitters.concentration
FROM activated_neurons
JOIN neurons ON activated_neurons.neuronID = neurons.neuronID
JOIN brain_regions ON neurons.regionID = brain_regions.regionID
JOIN emitted_neurotransmitters ON activated_neurons.activationID = emitted_neurotransmitters.activationID
JOIN neurotransmitters ON emitted_neurotransmitters.neurotransmitterID = neurotransmitters.neurotransmitterID
WHERE activated_neurons.duration > 10.0 AND emitted_neurotransmitters.concentration > 0.1;