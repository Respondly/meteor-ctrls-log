Package.describe({
  summary: 'UI controls for visually logging system state.'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'http']);
  api.use(['templating'], 'client');
  api.use(['css-stylus', 'ctrl', 'util']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('shared/ns.js', ['client', 'server']);
  api.add_files('client/json/json.html', 'client');
  api.add_files('client/json/json.coffee', 'client');
  api.add_files('client/json/json.styl', 'client');

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use('ctrls-log');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);

});
