var webpack = require('webpack');

module.exports = function(config) {
  config.set({
    basePath: '',
    files: [
      'src/**/*_test.ls'
    ],
    exclude: [],
    preprocessors: {
      'src/**/*_test.ls': ['webpack', 'sourcemap']
    },

    frameworks: ['mocha', 'sinon-chai', 'phantomjs-shim'],
    reporters: ['mocha'],

    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['PhantomJS'],
    singleRun: true,

    webpack: {
      devtool: 'inline-source-map',
      module: {
        loaders: [
          { test: /\.ls/, loader: 'livescript-loader' },
          { test: /\.json$/, loader: 'json-loader' },
          { test: /\.jade/, loader: 'jade-loader' },
          { test: /\.less$/, loader: 'style!css!less' },
          { test: /\.gif$/, loader: 'url-loader' },
        ]
      },
      resolve: {
        extensions: ['', '.js', '.ls', '.json']
      },
    },
    webpackMiddleware: {
      noInfo: true,
    },
  });
};
