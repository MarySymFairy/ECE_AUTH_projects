SELECT stimuli.stimulusType, stimuli.stimulusName
FROM subjects
JOIN experiments ON subjects.subjectID = experiments.subjectID
JOIN stimuli ON experiments.stimulusID = stimuli.stimulusID
WHERE subjects.species = 'Human';