restApi = new Restivus({
  useDefaultAuth: true,
  prettyJson: true
});

restApi.addCollection(Sessions, { path: 'sessions' });
restApi.addCollection(Scripts, { path: 'scripts' });
restApi.addCollection(Bots, { path: 'bots' });
