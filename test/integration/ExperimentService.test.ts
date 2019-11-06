import { Container } from 'typedi';
import { Connection } from 'typeorm';

import { Experiment, EXPERIMENT_STATE, CONSISTENCY_RULE, ASSIGNMENT_UNIT, POST_EXPERIMENT_RULE } from '../../src/api/models/Experiment';
import { ExperimentService } from '../../src/api/services/ExperimentService';
import { closeDatabase, createDatabaseConnection, migrateDatabase } from '../utils/database';
import { configureLogger } from '../utils/logger';

describe('ExperimentService', () => {

    // -------------------------------------------------------------------------
    // Setup up
    // -------------------------------------------------------------------------

    let connection: Connection;
    beforeAll(async () => {
        configureLogger();
        connection = await createDatabaseConnection();
    });
    beforeEach(() => migrateDatabase(connection));

    // -------------------------------------------------------------------------
    // Tear down
    // -------------------------------------------------------------------------

    afterAll(() => closeDatabase(connection));

    // -------------------------------------------------------------------------
    // Test cases
    // -------------------------------------------------------------------------

    test('should get a new experiment in the database with given ID', async (done) => {
        // const experiment = new Experiment();
        // experiment.id = 'ea6497f1-f7b8-4ec7-8ab3-d85af06aa634';
        // experiment.name = 'Test Experiment';
        // experiment.state = EXPERIMENT_STATE.INACTIVE;
        // experiment.consistencyRule = CONSISTENCY_RULE.INDIVIDUAL;
        // experiment.assignmentUnit = ASSIGNMENT_UNIT.INDIVIDUAL;
        // experiment.postExperimentRule = POST_EXPERIMENT_RULE.CONTINUE;

        const service = Container.get<ExperimentService>(ExperimentService);
        // const resultCreate = await service.create(experiment);
        // expect(resultCreate.name).toBe(experiment.name);
        // expect(resultCreate.state).toBe(experiment.state);

        const resultFind = await service.findOne('ea6497f1-f7b8-4ec7-8ab3-d85af06aa634');
        if (resultFind) {
            expect(resultFind.name).toBe('Test Experiment');
            expect(resultFind.state).toBe('inactive');
        } else {
            fail('Could not find experiment');
        }
        done();
    });

});
