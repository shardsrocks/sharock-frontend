require! {
  path: {join}
  webpack
}

prod = process.env.WEBPACK_ENV == 'production'

module.exports =
  context: __dirname
  entry: './src/main.ls'
  output:
    path: join(__dirname, 'dist')
    filename: 'bundle.js'

  module:
    loaders: [
      { test: /\.ls/, loader: 'livescript-loader' }
      { test: /\.json$/, loader: 'json-loader' }
      { test: /\.jade/, loader: 'jade-loader' }
      { test: /\.less$/, loader: 'style!css!less' }
      { test: /\.gif$/, loader: 'url-loader' }
    ]

  devtool: if prod then null else 'inline-source-map'
  plugins: if prod
    [
      new webpack.optimize.UglifyJsPlugin(
        compressor:
          warnings: false
        mangle: false
      )
    ]
  else
    []

  resolve:
    extensions: ['', '.js', '.ls', '.json']

  watchOptions:
    poll: true
