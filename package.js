Package.describe({
  name: 'respondly:ctrls-log',
  summary: 'UI controls for visually logging system state.',
  version: '1.0.2',
  git: 'https://github.com/Respondly/meteor-ctrls-log.git'
});



Package.onUse(function (api) {
  // api.versionsFrom('1.0');
  api.use(['coffeescript', 'http']);
  api.use(['templating', 'ui', 'spacebars'], 'client');
  api.use('respondly:css-stylus@1.0.3');
  api.use('respondly:ctrl@1.0.1');
  api.use('respondly:util@1.0.1');
  api.use('respondly:markdown@1.0.0');
  api.export('LogHandle');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('client/json/json.html', 'client');
  api.addFiles('client/log/log.html', 'client');
  api.addFiles('client/log-item/log-item.html', 'client');
  api.addFiles('client/log-value/log-value.html', 'client');
  api.addFiles('client/ns.js', 'client');
  api.addFiles('client/json/json.coffee', 'client');
  api.addFiles('client/json/json.styl', 'client');
  api.addFiles('client/log/log.coffee', 'client');
  api.addFiles('client/log/log.styl', 'client');
  api.addFiles('client/log-item/log-item.coffee', 'client');
  api.addFiles('client/log-item/log-item.styl', 'client');
  api.addFiles('client/log-value/log-value.coffee', 'client');
  api.addFiles('client/log-value/log-value.styl', 'client');
  api.addFiles('client/css.styl', 'client');
  api.addFiles('client/log-handle.coffee', 'client');
  api.addFiles('client/util.coffee', 'client');

});

Package.onTest(function(api){

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('tests/shared/sample.coffee', ['client', 'server']);

});
