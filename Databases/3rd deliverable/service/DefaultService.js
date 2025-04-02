// 'use strict';


// /**
//  * Delete an activated neuron by ID
//  *
//  * activationID Integer 
//  * no response value expected for this operation
//  **/
// exports.activated_neuronsActivationIDDELETE = function(activationID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific activated neuron by ID
//  *
//  * activationID Integer 
//  * returns ActivatedNeuron
//  **/
// exports.activated_neuronsActivationIDGET = function(activationID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "duration" : "duration",
//   "neuronID" : 6,
//   "experimentID" : 1,
//   "activationStrength" : "activationStrength",
//   "activationID" : 0
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update an activated neuron by ID
//  *
//  * body ActivatedNeuron 
//  * activationID Integer 
//  * no response value expected for this operation
//  **/
// exports.activated_neuronsActivationIDPUT = function(body,activationID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all activated neurons
//  *
//  * returns List
//  **/
// exports.activated_neuronsGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "duration" : "duration",
//   "neuronID" : 6,
//   "experimentID" : 1,
//   "activationStrength" : "activationStrength",
//   "activationID" : 0
// }, {
//   "duration" : "duration",
//   "neuronID" : 6,
//   "experimentID" : 1,
//   "activationStrength" : "activationStrength",
//   "activationID" : 0
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new activated neuron
//  *
//  * body ActivatedNeuron 
//  * no response value expected for this operation
//  **/
// exports.activated_neuronsPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all brain regions
//  *
//  * returns List
//  **/
// exports.brain_regionsGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "regionID" : 0,
//   "regionName" : "regionName",
//   "function" : "function",
//   "description" : "description"
// }, {
//   "regionID" : 0,
//   "regionName" : "regionName",
//   "function" : "function",
//   "description" : "description"
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new brain region
//  *
//  * body BrainRegion 
//  * no response value expected for this operation
//  **/
// exports.brain_regionsPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Delete a brain region by ID
//  *
//  * regionID Integer 
//  * no response value expected for this operation
//  **/
// exports.brain_regionsRegionIDDELETE = function(regionID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific brain region by ID
//  *
//  * regionID Integer 
//  * returns BrainRegion
//  **/
// exports.brain_regionsRegionIDGET = function(regionID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "regionID" : 0,
//   "regionName" : "regionName",
//   "function" : "function",
//   "description" : "description"
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update a brain region by ID
//  *
//  * body BrainRegion 
//  * regionID Integer 
//  * no response value expected for this operation
//  **/
// exports.brain_regionsRegionIDPUT = function(body,regionID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Delete an emitted neurotransmitter by ID
//  *
//  * emissionID Integer 
//  * no response value expected for this operation
//  **/
// exports.emitted_neurotransmittersEmissionIDDELETE = function(emissionID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific emitted neurotransmitter by ID
//  *
//  * emissionID Integer 
//  * returns EmittedNeurotransmitter
//  **/
// exports.emitted_neurotransmittersEmissionIDGET = function(emissionID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "concentration" : "concentration",
//   "neurotransmitterID" : 1,
//   "emissionID" : 0,
//   "activationID" : 6
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update an emitted neurotransmitter by ID
//  *
//  * body EmittedNeurotransmitter 
//  * emissionID Integer 
//  * no response value expected for this operation
//  **/
// exports.emitted_neurotransmittersEmissionIDPUT = function(body,emissionID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all emitted neurotransmitters
//  *
//  * returns List
//  **/
// exports.emitted_neurotransmittersGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "concentration" : "concentration",
//   "neurotransmitterID" : 1,
//   "emissionID" : 0,
//   "activationID" : 6
// }, {
//   "concentration" : "concentration",
//   "neurotransmitterID" : 1,
//   "emissionID" : 0,
//   "activationID" : 6
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new emitted neurotransmitter
//  *
//  * body EmittedNeurotransmitter 
//  * no response value expected for this operation
//  **/
// exports.emitted_neurotransmittersPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all experiment results
//  *
//  * returns List
//  **/
// exports.experiment_resultsGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "resultID" : 0,
//   "experimentID" : 6,
//   "resultDescription" : "resultDescription",
//   "significanceScore" : 1.4658129805029452
// }, {
//   "resultID" : 0,
//   "experimentID" : 6,
//   "resultDescription" : "resultDescription",
//   "significanceScore" : 1.4658129805029452
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new experiment result
//  *
//  * body ExperimentResult 
//  * no response value expected for this operation
//  **/
// exports.experiment_resultsPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Delete an experiment result by ID
//  *
//  * resultID Integer 
//  * no response value expected for this operation
//  **/
// exports.experiment_resultsResultIDDELETE = function(resultID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific experiment result by ID
//  *
//  * resultID Integer 
//  * returns ExperimentResult
//  **/
// exports.experiment_resultsResultIDGET = function(resultID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "resultID" : 0,
//   "experimentID" : 6,
//   "resultDescription" : "resultDescription",
//   "significanceScore" : 1.4658129805029452
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update an experiment result by ID
//  *
//  * body ExperimentResult 
//  * resultID Integer 
//  * no response value expected for this operation
//  **/
// exports.experiment_resultsResultIDPUT = function(body,resultID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Delete an experiment by ID
//  *
//  * experimentID Integer 
//  * no response value expected for this operation
//  **/
// exports.experimentsExperimentIDDELETE = function(experimentID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific experiment by ID
//  *
//  * experimentID Integer 
//  * returns Experiment
//  **/
// exports.experimentsExperimentIDGET = function(experimentID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "dateTime" : "dateTime",
//   "observation" : "observation",
//   "stimulusID" : 1,
//   "experimentID" : 0,
//   "subjectID" : 6
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update an experiment by ID
//  *
//  * body Experiment 
//  * experimentID Integer 
//  * no response value expected for this operation
//  **/
// exports.experimentsExperimentIDPUT = function(body,experimentID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all experiments
//  *
//  * returns List
//  **/
// exports.experimentsGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "dateTime" : "dateTime",
//   "observation" : "observation",
//   "stimulusID" : 1,
//   "experimentID" : 0,
//   "subjectID" : 6
// }, {
//   "dateTime" : "dateTime",
//   "observation" : "observation",
//   "stimulusID" : 1,
//   "experimentID" : 0,
//   "subjectID" : 6
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new experiment
//  *
//  * body Experiment 
//  * no response value expected for this operation
//  **/
// exports.experimentsPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all neurons
//  *
//  * returns List
//  **/
// exports.neuronsGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "regionID" : 6,
//   "thresholdPotential" : "thresholdPotential",
//   "neuronID" : 0,
//   "type" : "type"
// }, {
//   "regionID" : 6,
//   "thresholdPotential" : "thresholdPotential",
//   "neuronID" : 0,
//   "type" : "type"
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Delete a neuron by ID
//  *
//  * neuronID Integer 
//  * no response value expected for this operation
//  **/
// exports.neuronsNeuronIDDELETE = function(neuronID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific neuron by ID
//  *
//  * neuronID Integer 
//  * returns Neuron
//  **/
// exports.neuronsNeuronIDGET = function(neuronID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "regionID" : 6,
//   "thresholdPotential" : "thresholdPotential",
//   "neuronID" : 0,
//   "type" : "type"
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update a neuron by ID
//  *
//  * body Neuron 
//  * neuronID Integer 
//  * no response value expected for this operation
//  **/
// exports.neuronsNeuronIDPUT = function(body,neuronID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Create a new neuron
//  *
//  * body Neuron 
//  * no response value expected for this operation
//  **/
// exports.neuronsPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all neurotransmitters
//  *
//  * returns List
//  **/
// exports.neurotransmittersGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "name" : "name",
//   "description" : "description",
//   "neurotransmitterID" : 0,
//   "effectType" : "effectType"
// }, {
//   "name" : "name",
//   "description" : "description",
//   "neurotransmitterID" : 0,
//   "effectType" : "effectType"
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Delete a neurotransmitter by ID
//  *
//  * neurotransmitterID Integer 
//  * no response value expected for this operation
//  **/
// exports.neurotransmittersNeurotransmitterIDDELETE = function(neurotransmitterID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific neurotransmitter by ID
//  *
//  * neurotransmitterID Integer 
//  * returns Neurotransmitter
//  **/
// exports.neurotransmittersNeurotransmitterIDGET = function(neurotransmitterID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "name" : "name",
//   "description" : "description",
//   "neurotransmitterID" : 0,
//   "effectType" : "effectType"
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update a neurotransmitter by ID
//  *
//  * body Neurotransmitter 
//  * neurotransmitterID Integer 
//  * no response value expected for this operation
//  **/
// exports.neurotransmittersNeurotransmitterIDPUT = function(body,neurotransmitterID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Create a new neurotransmitter
//  *
//  * body Neurotransmitter 
//  * no response value expected for this operation
//  **/
// exports.neurotransmittersPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all stimuli
//  *
//  * returns List
//  **/
// exports.stimuliGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "stimulusID" : 0,
//   "intensityOrDose" : "intensityOrDose",
//   "name" : "name",
//   "description" : "description",
//   "type" : "type"
// }, {
//   "stimulusID" : 0,
//   "intensityOrDose" : "intensityOrDose",
//   "name" : "name",
//   "description" : "description",
//   "type" : "type"
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new stimulus
//  *
//  * body Stimulus 
//  * no response value expected for this operation
//  **/
// exports.stimuliPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Delete a stimulus by ID
//  *
//  * stimulusID Integer 
//  * no response value expected for this operation
//  **/
// exports.stimuliStimulusIDDELETE = function(stimulusID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific stimulus by ID
//  *
//  * stimulusID Integer 
//  * returns Stimulus
//  **/
// exports.stimuliStimulusIDGET = function(stimulusID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "stimulusID" : 0,
//   "intensityOrDose" : "intensityOrDose",
//   "name" : "name",
//   "description" : "description",
//   "type" : "type"
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update a stimulus by ID
//  *
//  * body Stimulus 
//  * stimulusID Integer 
//  * no response value expected for this operation
//  **/
// exports.stimuliStimulusIDPUT = function(body,stimulusID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all subjects
//  *
//  * returns List
//  **/
// exports.subjectsGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "gender" : "gender",
//   "species" : "species",
//   "subjectID" : 0,
//   "age" : 6
// }, {
//   "gender" : "gender",
//   "species" : "species",
//   "subjectID" : 0,
//   "age" : 6
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new subject
//  *
//  * body Subject 
//  * no response value expected for this operation
//  **/
// exports.subjectsPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Delete a subject by ID
//  *
//  * subjectID Integer 
//  * no response value expected for this operation
//  **/
// exports.subjectsSubjectIDDELETE = function(subjectID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific subject by ID
//  *
//  * subjectID Integer 
//  * returns Subject
//  **/
// exports.subjectsSubjectIDGET = function(subjectID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "gender" : "gender",
//   "species" : "species",
//   "subjectID" : 0,
//   "age" : 6
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update a subject by ID
//  *
//  * body Subject 
//  * subjectID Integer 
//  * no response value expected for this operation
//  **/
// exports.subjectsSubjectIDPUT = function(body,subjectID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get all synapses
//  *
//  * returns List
//  **/
// exports.synapsesGET = function() {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = [ {
//   "preSynapticNeuronID" : 6,
//   "strength" : "strength",
//   "postSynapticNeuronID" : 1,
//   "synapseID" : 0
// }, {
//   "preSynapticNeuronID" : 6,
//   "strength" : "strength",
//   "postSynapticNeuronID" : 1,
//   "synapseID" : 0
// } ];
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Create a new synapse
//  *
//  * body Synapse 
//  * no response value expected for this operation
//  **/
// exports.synapsesPOST = function(body) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Delete a synapse by ID
//  *
//  * synapseID Integer 
//  * no response value expected for this operation
//  **/
// exports.synapsesSynapseIDDELETE = function(synapseID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }


// /**
//  * Get a specific synapse by ID
//  *
//  * synapseID Integer 
//  * returns Synapse
//  **/
// exports.synapsesSynapseIDGET = function(synapseID) {
//   return new Promise(function(resolve, reject) {
//     var examples = {};
//     examples['application/json'] = {
//   "preSynapticNeuronID" : 6,
//   "strength" : "strength",
//   "postSynapticNeuronID" : 1,
//   "synapseID" : 0
// };
//     if (Object.keys(examples).length > 0) {
//       resolve(examples[Object.keys(examples)[0]]);
//     } else {
//       resolve();
//     }
//   });
// }


// /**
//  * Update a synapse by ID
//  *
//  * body Synapse 
//  * synapseID Integer 
//  * no response value expected for this operation
//  **/
// exports.synapsesSynapseIDPUT = function(body,synapseID) {
//   return new Promise(function(resolve, reject) {
//     resolve();
//   });
// }

