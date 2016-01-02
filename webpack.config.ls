require! {
  path: {join}
  webpack
}

module.exports =
  context: __dirname
  entry: './src/main.ls'
  output:
    path: join(__dirname, 'dist')
    filename: 'bundle.js'

  devtool: 'inline-source-map'
  module:
    loaders: [
      { test: /\.ls/, loader: 'livescript-loader' }
      { test: /\.json$/, loader: 'json-loader' }
      { test: /\.jade/, loader: 'jade-loader' }
      { test: /\.less$/, loader: 'style!css!less' }
      { test: /\.gif$/, loader: 'url-loader' }
    ]

  resolve:
    extensions: ['', '.js', '.ls', '.json']

  watchOptions:
    poll: true
