{EnvironmentPlugin} = require 'webpack'
CompressionWebpackPlugin = require 'compression-webpack-plugin'

module.exports =
  publicPath: './'
  lintOnSave: false
  devServer:
    host: '0.0.0.0'
    disableHostCheck: true
  configureWebpack: (config) ->
    config.node.url = true
    config.plugins.push new EnvironmentPlugin [
      'HKEXURL'
      'MQTTURL'
      'MQTTTOPIC'
    ]
    config.module.rules.push
      test: /\.coffee$/
      use: ['babel-loader', 'coffee-loader']
    return
