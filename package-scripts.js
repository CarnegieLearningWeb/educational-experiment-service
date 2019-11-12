const { series, rimraf } = require('nps-utils');

module.exports = {
  scripts: {
    default: 'nps',
    help: 'npm start help',
    test: 'echo "Error: no test specified" && exit 1',
    /**
     * Serves the current app and watches for changes to restart it
     */
    serve: {
      inspector: {
        script: series('nps banner.serve', 'nodemon --inspect'),
        description: 'Serves the current app and watches for changes to restart it, you may attach inspector to it.'
      },
      script: series('nps banner.serve', 'nodemon'),
      description: 'Serves the current app and watches for changes to restart it'
    },
    /**
     * Creates the needed configuration files
     */
    config: {
      script: series(runFast('./commands/tsconfig.ts')),
      hiddenFromHelp: true
    },
    /**
     * Builds the app into the dist directory
     */
    build: {
      script: series(
        'nps banner.build',
        'nps config',
        'nps lint',
        'nps clean.dist',
        'nps transpile'
        // 'nps copy',
        // 'nps copy.tmp',
        // 'nps clean.tmp'
      ),
      description: 'Builds the app into the dist directory'
    },
    /**
     * Runs TSLint over your project
     */
    lint: {
      script: tslint(`./src/**/*.ts`),
      hiddenFromHelp: true
    },
    /**
     * Transpile your app into javascript
     */
    transpile: {
      script: `tsc --project ./tsconfig.build.json`,
      hiddenFromHelp: true
    },
    /**
     * Clean files and folders
     */
    clean: {
      default: {
        script: series(`nps banner.clean`, `nps clean.dist`),
        description: 'Deletes the ./dist folder'
      },
      dist: {
        script: rimraf('./dist'),
        hiddenFromHelp: true
      },
      tmp: {
        script: rimraf('./.tmp'),
        hiddenFromHelp: true
      }
    },
    /**
     * This creates pretty banner to the terminal
     */
    banner: {
      build: banner('build'),
      serve: banner('serve'),
      testUnit: banner('test.unit'),
      testIntegration: banner('test.integration'),
      testE2E: banner('test.e2e'),
      migrate: banner('migrate'),
      seed: banner('seed'),
      reverst: banner('revert'),
      clean: banner('clean')
    }
  }
};

function banner(name) {
  return {
    hiddenFromHelp: true,
    silent: true,
    description: `Shows ${name} banners to the console`,
    script: runFast(`./commands/banner.ts ${name}`)
  };
}

function runFast(path) {
  return `ts-node --transpile-only ${path}`;
}

function tslint(path) {
  return `tslint ${path} -c ./tslint.json --format stylish`;
}