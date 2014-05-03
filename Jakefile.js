var spawn = require('child_process').spawn;

desc('This is the default task.');
task('default', [], function() {
  console.log('Implement the default task.');
});

desc('Downloads nodejs modules');
task('modules', [], function() {
  jake.exec('npm install', {stdout: true, stderr: true});
}, true);

desc('Builds the project');
task('build', [], function() {
  console.log('Removing app/ folder...');
  jake.exec('rm -rf app', function() {
    console.log('Creating empty app/ folder...');
    jake.exec('mkdir app', function() {
      console.log('Copying statics and compiling CoffeeScript sources...');
      var num = 0;
      var endFunc =  function() { 
        num += 1;
        if (num == 2) {
          complete();
        }
      };
      jake.exec('cp -r static/* app/', endFunc, {stdout: true, stderr: true});
      jake.exec('coffee -m -b -o app/ -c src', endFunc, {stdout: true, stderr: true});
    }, {stdout: true, stderr: true});
  }, {stdout: true, stderr: true});
}, true);

desc('Cleans the project');
task('clean', [], function() {
  jake.exec('find -iname "*.map" | xargs rm', {stdout: true, stderr: true});
}, true);

desc('Cleans all generated and downloaded content from the project');
task('clean-all', [], function() {
  jake.exec('rm -rf app', {stdout: true, stderr: true});
  jake.exec('rm -rf node_modules', {stdout: true, stderr: true});
}, true);

desc('Runs the tests.');
task('test', [], function() {
  jake.exec('buster-test -c app/spec/buster.js', function() {
    complete();
  }, {stdout: true, stderr: true});
}, true);

namespace('server', function() {
  desc('Run nodejs server.');
  task('run', ['build'], function() {
    jake.exec('node app/app.js', function() {
      complete();
    }, {stdout: true, stderr: true});
  }, true);
});

namespace('compiler', function() {
  desc('Run CoffeeScript compilation.');
  task('run', [], function() {
    jake.exec('coffee -m -w -b -o app/ -c src', function() {
      complete();
    }, {stdout: true, stderr: true});
  }, true);
});
