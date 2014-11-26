Package.describe({
  name: 'respondly:ctrls-log',
  summary: 'UI controls for visually logging system state.',
  version: '0.0.1',
  git: 'https://github.com/Respondly/meteor-ctrls-log.git'
});



Package.onUse(function (api) {
  api.use(['coffeescript', 'http']);
  api.use(['templating', 'ui', 'spacebars'], 'client');
  api.use(['respondly:css-stylus', 'respondly:ctrl', 'respondly:util']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('client/json/json.html', 'client');
  api.addFiles('client/log/log.html', 'client');
  api.addFiles('client/ns.js', 'client');
  api.addFiles('client/json/json.coffee', 'client');
  api.addFiles('client/json/json.styl', 'client');
  api.addFiles('client/log/log.coffee', 'client');
  api.addFiles('client/log/log.styl', 'client');

});


