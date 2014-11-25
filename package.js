Package.describe({
  name: 'respondly:ctrls-log',
  summary: 'UI controls for visually logging system state.',
  version: '0.0.1',
  git: 'https://github.com/Respondly/meteor-ctrls-log.git'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'http']);
  api.use(['templating', 'ui', 'spacebars'], 'client');
  api.use(['respondly:css-stylus', 'respondly:ctrl', 'respondly:util']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('client/json/json.html', 'client');
  api.add_files('client/log/log.html', 'client');
  api.add_files('client/ns.js', 'client');
  api.add_files('client/json/json.coffee', 'client');
  api.add_files('client/json/json.styl', 'client');
  api.add_files('client/log/log.coffee', 'client');
  api.add_files('client/log/log.styl', 'client');

});


