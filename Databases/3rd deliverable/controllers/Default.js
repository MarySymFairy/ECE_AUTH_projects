'use strict';

require('dotenv').config(); // Load environment variables
const mysql = require('mysql2/promise');
const utils = require('../utils/writer.js');
var Default = require('../service/DefaultService');

// Create a database connection pool
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  waitForConnections: true,
  connectionLimit: 100,
  queueLimit: 0,
});

//Activated Neurons Functions
module.exports.activated_neuronsActivationIDDELETE = async function activated_neuronsActivationIDDELETE(req, res, next, activationID) {
  try {
    const query = 'DELETE FROM activated_neurons WHERE activationID = ?';
    const [result] = await db.query(query, [activationID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Activation ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Activation deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.activated_neuronsActivationIDGET = async function activated_neuronsActivationIDGET(req, res, next, activationID) {
  try {
    const query = 'SELECT * FROM activated_neurons WHERE activationID = ?';
    const [rows] = await db.query(query, [activationID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Activation ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.activated_neuronsActivationIDPUT = async function activated_neuronsActivationIDPUT(req, res, next, body, activationID) {
  try {
    const { duration, neuronID, experimentID, activationStrength, activationID } = body;
    const query = 'UPDATE activated_neurons SET duration = ?, neuronID = ?, experimentID = ?, activationStrength = ? WHERE activationID = ?';
    const [result] = await db.query(query, [ duration, neuronID, experimentID, activationStrength, activationID ]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Activation ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Activation updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.activated_neuronsGET = async function activated_neuronsGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM activated_neurons');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.activated_neuronsPOST = async function activated_neuronsPOST(req, res, next, body) {
  try {
    const { duration, neuronID, experimentID, activationStrength, activationID } = body;
    const query = 'INSERT INTO activated_neurons (duration, neuronID, experimentID, activationStrength, activationID) VALUES (?, ?, ?, ?, ?)';
    const [result] = await db.query(query, [duration, neuronID, experimentID, activationStrength, activationID ]);
    utils.writeJson(res, { message: 'Neuron activated', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};


// Brain Regions Functions
module.exports.brain_regionsGET = async function brain_regionsGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM brain_regions');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.brain_regionsPOST = async function brain_regionsPOST(req, res, next, body) {
  try {
    const { regionID, regionName, regionFunction, regionDescription } = body;
    const query = 'INSERT INTO brain_regions ( regionID, regionName, regionFunction, regionDescription ) VALUES (?, ?, ?, ?)';
    const [result] = await db.query(query, [ regionID, regionName, regionFunction, regionDescription ]);
    utils.writeJson(res, { message: 'Brain region added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.brain_regionsRegionIDDELETE = async function brain_regionsRegionIDDELETE(req, res, next, regionID) {
  try {
    const query = 'DELETE FROM brain_regions WHERE regionID = ?';
    const [result] = await db.query(query, [regionID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Region ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Brain region deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.brain_regionsRegionIDGET = async function brain_regionsRegionIDGET(req, res, next, regionID) {
  try {
    const query = 'SELECT * FROM brain_regions WHERE regionID = ?';
    const [rows] = await db.query(query, [regionID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Region ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.brain_regionsRegionIDPUT = async function brain_regionsRegionIDPUT(req, res, next, body, regionID) {
  try {
    const { regionID, regionName, regionFunction, regionDescription} = body;
    const query = 'UPDATE brain_regions SET regionName = ?, regionFunction = ?, regionDescription = ? WHERE regionID = ?';
    const [result] = await db.query(query, [ regionName, regionFunction, regionDescription, regionID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Region ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Brain region updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};


// Emitted Neurotransmitters Functions
module.exports.emitted_neurotransmittersGET = async function emitted_neurotransmittersGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM emitted_neurotransmitters');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.emitted_neurotransmittersPOST = async function emitted_neurotransmittersPOST(req, res, next, body) {
  try {
    const { concentration , neurotransmitterID, emissionID, activationID  } = body;
    const query = 'INSERT INTO emitted_neurotransmitters (concentration , neurotransmitterID, emissionID, activationID) VALUES (?, ?, ?, ?)';
    const [result] = await db.query(query, [concentration , neurotransmitterID, emissionID, activationID ]);
    utils.writeJson(res, { message: 'Neurotransmitter emitted', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.emitted_neurotransmittersEmissionIDDELETE = async function emitted_neurotransmittersEmissionIDDELETE(req, res, next, emissionID) {
  try {
    const query = 'DELETE FROM emitted_neurotransmitters WHERE emissionID = ?';
    const [result] = await db.query(query, [emissionID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Emission ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Neurotransmitter emission deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.emitted_neurotransmittersEmissionIDGET = async function emitted_neurotransmittersEmissionIDGET(req, res, next, emissionID) {
  try {
    const query = 'SELECT * FROM emitted_neurotransmitters WHERE emissionID = ?';
    const [rows] = await db.query(query, [emissionID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Emission ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.emitted_neurotransmittersEmissionIDPUT = async function emitted_neurotransmittersEmissionIDPUT(req, res, next, body, emissionID) {
  try {
    const { concentration , neurotransmitterID, emissionID, activationID} = body;
    const query = 'UPDATE emitted_neurotransmitters SET concentration = ?, neurotransmitterID = ?, activationID = ? WHERE emissionID = ?';
    const [result] = await db.query(query, [ concentration , neurotransmitterID, activationID, emissionID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Emission ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Neurotransmitter emission updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

// Experiment Results Functions
module.exports.experiment_resultsGET = async function experiment_resultsGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM experiment_results');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experiment_resultsPOST = async function experiment_resultsPOST(req, res, next, body) {
  try {
    const { resultID, experimentID, resultDescription, significanceScore } = body;
    const query = 'INSERT INTO experiment_results ( resultID, experimentID, resultDescription, significanceScore ) VALUES (?, ?, ?, ?)';
    const [result] = await db.query(query, [ resultID, experimentID, resultDescription, significanceScore ]);
    utils.writeJson(res, { message: 'Experiment result added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experiment_resultsResultIDDELETE = async function experiment_resultsResultIDDELETE(req, res, next, resultID) {
  try {
    const query = 'DELETE FROM experiment_results WHERE resultID = ?';
    const [result] = await db.query(query, [resultID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Result ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Experiment result deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experiment_resultsResultIDGET = async function experiment_resultsResultIDGET(req, res, next, resultID) {
  try {
    const query = 'SELECT * FROM experiment_results WHERE resultID = ?';
    const [rows] = await db.query(query, [resultID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Result ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experiment_resultsResultIDPUT = async function experiment_resultsResultIDPUT(req, res, next, body, resultID) {
  try {
    const {  resultID, experimentID, resultDescription, significanceScore } = body;
    const query = 'UPDATE experiment_results SET experimentID = ?, resultDescription = ?, significanceScore = ? WHERE resultID = ?';
    const [result] = await db.query(query, [experimentID, resultDescription, significanceScore, resultID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Result ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Experiment result updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

// Experiments Functions
module.exports.experimentsGET = async function experimentsGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM experiments');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experimentsPOST = async function experimentsPOST(req, res, next, body) {
  try {
    const { experimentDateTime, observation, stimulusID, experimentID, subjectID } = body;
    const query = 'INSERT INTO experiments ( experimentID, subjectID, stimulusID, experimentDateTime, observation ) VALUES (?, ?, ?, ?, ?)';
    const [result] = await db.query(query, [ experimentID, subjectID, stimulusID, experimentDateTime, observation ]);
    utils.writeJson(res, { message: 'Experiment added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experimentsExperimentIDDELETE = async function experimentsExperimentIDDELETE(req, res, next, experimentID) {
  try {
    const query = 'DELETE FROM experiments WHERE experimentID = ?';
    const [result] = await db.query(query, [experimentID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Experiment ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Experiment deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experimentsExperimentIDGET = async function experimentsExperimentIDGET(req, res, next, experimentID) {
  try {
    const query = 'SELECT * FROM experiments WHERE experimentID = ?';
    const [rows] = await db.query(query, [experimentID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Experiment ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.experimentsExperimentIDPUT = async function experimentsExperimentIDPUT(req, res, next, body, experimentID) {
  try {
    const { experimentDateTime, observation, stimulusID, experimentID, subjectID} = body;
    const query = 'UPDATE experiments SET experimentDateTime = ?, observation = ?, stimulusID = ?, subjectID = ? WHERE experimentID = ?';
    const [result] = await db.query(query, [ experimentDateTime, observation, stimulusID, subjectID, experimentID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Experiment ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Experiment updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

// Neurons Functions
module.exports.neuronsGET = async function neuronsGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM neurons');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neuronsPOST = async function neuronsPOST(req, res, next, body) {
  try {
    const { regionID, thresholdPotential, neuronID, neuronType } = body;
    const query = 'INSERT INTO neurons ( neuronID, regionID, neuronType, thresholdPotential) VALUES (?, ?, ?, ?)';
    const [result] = await db.query(query, [neuronID, regionID, neuronType, thresholdPotential]);
    utils.writeJson(res, { message: 'Neuron added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neuronsNeuronIDDELETE = async function neuronsNeuronIDDELETE(req, res, next, neuronID) {
  try {
    const query = 'DELETE FROM neurons WHERE neuronID = ?';
    const [result] = await db.query(query, [neuronID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Neuron ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Neuron deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neuronsNeuronIDGET = async function neuronsNeuronIDGET(req, res, next, neuronID) {
  try {
    const query = 'SELECT * FROM neurons WHERE neuronID = ?';
    const [rows] = await db.query(query, [neuronID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Neuron ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neuronsNeuronIDPUT = async function neuronsNeuronIDPUT(req, res, next, body, neuronID) {
  try {
    const { regionID, thresholdPotential, neuronID, neuronType} = body;
    const query = 'UPDATE neurons SET regionID = ?, thresholdPotential = ?, neuronType = ? WHERE neuronID = ?';
    const [result] = await db.query(query, [ regionID, thresholdPotential, neuronType, neuronID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Neuron ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Neuron updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

// Neurotransmitters Functions
module.exports.neurotransmittersGET = async function neurotransmittersGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM neurotransmitters');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neurotransmittersPOST = async function neurotransmittersPOST(req, res, next, body) {
  try {
    const { neurotransmitterName, neurotransmitterDescription, neurotransmitterID, effectType } = body;
    const query = 'INSERT INTO neurotransmitters (neurotransmitterID, neurotransmitterName, effectType, neurotransmitterDescription) VALUES (?, ?, ?, ?)';
    const [result] = await db.query(query, [neurotransmitterID, neurotransmitterName, effectType, neurotransmitterDescription]);
    utils.writeJson(res, { message: 'Neurotransmitter added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neurotransmittersNeurotransmitterIDDELETE = async function neurotransmittersNeurotransmitterIDDELETE(req, res, next, neurotransmitterID) {
  try {
    const query = 'DELETE FROM neurotransmitters WHERE neurotransmitterID = ?';
    const [result] = await db.query(query, [neurotransmitterID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Neurotransmitter ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Neurotransmitter deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neurotransmittersNeurotransmitterIDGET = async function neurotransmittersNeurotransmitterIDGET(req, res, next, neurotransmitterID) {
  try {
    const query = 'SELECT * FROM neurotransmitters WHERE neurotransmitterID = ?';
    const [rows] = await db.query(query, [neurotransmitterID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Neurotransmitter ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.neurotransmittersNeurotransmitterIDPUT = async function neurotransmittersNeurotransmitterIDPUT(req, res, next, body, neurotransmitterID) {
  try {
    const { neurotransmitterName, neurotransmitterDescription, neurotransmitterID, effectType } = body;
    const query = 'UPDATE neurotransmitters SET neurotransmitterName = ?, neurotransmitterDescription = ?, effectType = ? WHERE neurotransmitterID = ?';
    const [result] = await db.query(query, [neurotransmitterName, neurotransmitterDescription, effectType, neurotransmitterID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Neurotransmitter ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Neurotransmitter updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

// Stimuli Functions
module.exports.stimuliGET = async function stimuliGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM stimuli');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.stimuliPOST = async function stimuliPOST(req, res, next, body) {
  try {
    const { stimulusID, intensityOrDose, stimulusName, stimulusDescription, stimulusType } = body;
    const query = 'INSERT INTO stimuli (stimulusID, intensityOrDose, stimulusName, stimulusDescription, stimulusType) VALUES (?, ?, ?, ?, ?)';
    const [result] = await db.query(query, [stimulusID, intensityOrDose, stimulusName, stimulusDescription, stimulusType]);
    utils.writeJson(res, { message: 'Stimulus added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.stimuliStimulusIDDELETE = async function stimuliStimulusIDDELETE(req, res, next, stimulusID) {
  try {
    const query = 'DELETE FROM stimuli WHERE stimulusID = ?';
    const [result] = await db.query(query, [stimulusID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Stimulus ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Stimulus deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.stimuliStimulusIDGET = async function stimuliStimulusIDGET(req, res, next, stimulusID) {
  try {
    const query = 'SELECT * FROM stimuli WHERE stimulusID = ?';
    const [rows] = await db.query(query, [stimulusID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Stimulus ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.stimuliStimulusIDPUT = async function stimuliStimulusIDPUT(req, res, next, body, stimulusID) {
  try {
    const {  stimulusID, intensityOrDose, stimulusName, stimulusDescription, stimulusType } = body;
    const query = 'UPDATE stimuli SET stimulusName = ?, stimulusDescription = ?, stimulusType = ?, intensityOrDose = ? WHERE stimulusID = ?';
    const [result] = await db.query(query, [stimulusName, stimulusDescription, stimulusType, intensityOrDose, stimulusID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Stimulus ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Stimulus updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

// Subjects Functions
module.exports.subjectsGET = async function subjectsGET(req, res, next) {
  try {
    const [rows] = await db.query('SELECT * FROM subjects');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.subjectsPOST = async function subjectsPOST(req, res, next, body) {
  try {
    const { gender, species, subjectID, age } = body;
    const query = 'INSERT INTO subjects (gender, species, subjectID, age) VALUES (?, ?, ?, ?)';
    const [result] = await db.query(query, [gender, species, subjectID, age]);
    utils.writeJson(res, { message: 'Subject added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.subjectsSubjectIDDELETE = async function subjectsSubjectIDDELETE(req, res, next, subjectID) {
  try {
    const query = 'DELETE FROM subjects WHERE subjectID = ?';
    const [result] = await db.query(query, [subjectID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Subject ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Subject deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.subjectsSubjectIDGET = async function subjectsSubjectIDGET(req, res, next, subjectID) {
  try {
    const query = 'SELECT * FROM subjects WHERE subjectID = ?';
    const [rows] = await db.query(query, [subjectID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Subject ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.subjectsSubjectIDPUT = async function subjectsSubjectIDPUT(req, res, next, body, subjectID) {
  try {
    const { gender, species, subjectID, age  } = body;
    const query = 'UPDATE subjects SET gender = ?, species = ?, age = ? WHERE subjectID = ?';
    const [result] = await db.query(query, [ gender, species, age, subjectID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Subject ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Subject updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

// Synapses Functions
module.exports.synapsesGET = async function synapsesGET(req, res, next) {
  try {
    console.log('synapsesGET called');

    const [rows] = await db.query('SELECT * FROM synapses');
    utils.writeJson(res, rows);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.synapsesPOST = async function synapsesPOST(req, res, next, body) {
  try {
    const { PreSynapticNeuronID, strength, PostSynapticNeuronID, synapseID } = body;
    const query = 'INSERT INTO synapses ( PreSynapticNeuronID, strength, PostSynapticNeuronID, synapseID ) VALUES (?, ?, ?, ?)';
    const [result] = await db.query(query, [ PreSynapticNeuronID, strength, PostSynapticNeuronID, synapseID ]);
    utils.writeJson(res, { message: 'Synapse added', id: result.insertId });
  } catch (err) {
    console.error('Database insert failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.synapsesSynapseIDDELETE = async function synapsesSynapseIDDELETE(req, res, next, synapseID) {
  try {
    const query = 'DELETE FROM synapses WHERE synapseID = ?';
    const [result] = await db.query(query, [synapseID]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Synapse ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Synapse deleted successfully' });
  } catch (err) {
    console.error('Database delete failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.synapsesSynapseIDGET = async function synapsesSynapseIDGET(req, res, next, synapseID) {
  try {
    const query = 'SELECT * FROM synapses WHERE synapseID = ?';
    const [rows] = await db.query(query, [synapseID]);
    if (rows.length === 0) {
      return utils.writeJson(res, { message: 'Synapse ID not found' }, 404);
    }
    utils.writeJson(res, rows[0]);
  } catch (err) {
    console.error('Database query failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};

module.exports.synapsesSynapseIDPUT = async function synapsesSynapseIDPUT(req, res, next, body, synapseID) {
  try {
    const { PreSynapticNeuronID, strength, PostSynapticNeuronID, synapseID } = body;
    const query = 'UPDATE synapses SET PreSynapticNeuronID = ?, strength = ?, PostSynapticNeuronID = ? WHERE synapseID = ?';
    const [result] = await db.query(query, [ PreSynapticNeuronID, strength, PostSynapticNeuronID, synapseID ]);
    if (result.affectedRows === 0) {
      return utils.writeJson(res, { message: 'Synapse ID not found' }, 404);
    }
    utils.writeJson(res, { message: 'Synapse updated successfully' });
  } catch (err) {
    console.error('Database update failed:', err);
    utils.writeJson(res, { message: 'Internal Server Error' }, 500);
  }
};
