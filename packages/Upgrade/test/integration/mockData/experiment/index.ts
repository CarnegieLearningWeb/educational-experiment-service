import { experiment, experimentSecond, experimentThird } from './raw';
import { CONSISTENCY_RULE, ASSIGNMENT_UNIT, POST_EXPERIMENT_RULE, EXPERIMENT_STATE } from 'upgrade_types';

export const individualAssignmentExperiment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.INDIVIDUAL,
  assignmentUnit: ASSIGNMENT_UNIT.INDIVIDUAL,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const individualAssignmentExperimentConsistencyRuleExperiemnt = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.EXPERIMENT,
  assignmentUnit: ASSIGNMENT_UNIT.INDIVIDUAL,
  postExperimentRule: POST_EXPERIMENT_RULE.ASSIGN,
  revertTo: experiment.conditions[0].id,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupAssignmentWithGroupConsistencyExperiment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.GROUP,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupAssignmentWithIndividulaConsistencyExperiment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.INDIVIDUAL,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupAssignmentWithExperimentConsistencyExperiment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.EXPERIMENT,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupAssignmentWithGroupConsistencyExperimentSwitchBeforeAssignment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.GROUP,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupAssignmentWithGroupConsistencyExperimentSwitchAfterAssignment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.GROUP,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupAssignmentWithIndividualConsistencyExperimentSwitchAfterAssignment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.INDIVIDUAL,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupAssignmentWithExperimentConsistencyExperimentSwitchAfterAssignment = {
  ...experiment,
  consistencyRule: CONSISTENCY_RULE.EXPERIMENT,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const individualExperimentWithMetric = {
  ...individualAssignmentExperiment,
  metrics: [
    {
      key: 'time',
      children: [],
    },
    {
      key: 'w',
      children: [
        {
          key: 'time',
          children: [],
        },
        {
          key: 'completion',
          children: [],
        },
      ],
    },
  ],
};

export const scheduleJobStartExperiment = { ...experiment, state: EXPERIMENT_STATE.SCHEDULED };

export const scheduleJobEndExperiment = {
  ...experiment,
  endOn: new Date().toISOString(),
};

export const scheduleJobUpdateExperiment = scheduleJobEndExperiment;

export const revertToDefault = {
  ...individualAssignmentExperimentConsistencyRuleExperiemnt,
  revertTo: undefined,
};

export const revertToCondition = {
  ...individualAssignmentExperimentConsistencyRuleExperiemnt,
};

export const individualExperimentStats = {
  ...individualAssignmentExperiment,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const groupExperimentStats = {
  ...groupAssignmentWithGroupConsistencyExperiment,
  state: EXPERIMENT_STATE.INACTIVE,
};

export const previewIndividualAssignmentExperiment = {
  ...individualAssignmentExperiment,
  state: EXPERIMENT_STATE.PREVIEW,
};

export const previewGroupExperiment = {
  ...groupAssignmentWithGroupConsistencyExperiment,
  state: EXPERIMENT_STATE.PREVIEW,
};

export const secondExperiment = {
  ...experimentSecond,
};

export const groupAssignmentWithIndividualConsistencyExperimentSecond = {
  ...secondExperiment,
  consistencyRule: CONSISTENCY_RULE.INDIVIDUAL,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
}

export const groupAndParticipantsExperiment = {
  ...groupAssignmentWithGroupConsistencyExperiment,
  state: EXPERIMENT_STATE.INACTIVE,
  enrollmentCompleteCondition: {
    groupCount: 2,
    userCount: 2,
  },
};

export const participantsOnlyExperiment = {
  ...individualAssignmentExperiment,
  state: EXPERIMENT_STATE.INACTIVE,
  enrollmentCompleteCondition: {
    userCount: 2,
  },
};

export const thirdExperiment = {
  ...experimentThird,
};

export const groupAssignmentWithIndividualConsistencyExperimentThird = {
  ...thirdExperiment,
  consistencyRule: CONSISTENCY_RULE.INDIVIDUAL,
  assignmentUnit: ASSIGNMENT_UNIT.GROUP,
  postExperimentRule: POST_EXPERIMENT_RULE.CONTINUE,
  state: EXPERIMENT_STATE.INACTIVE,
}
