#= base
@expect = chai.expect


if Meteor.isClient
  Meteor.startup -> $('title').html('Tests: ctrls-log')
