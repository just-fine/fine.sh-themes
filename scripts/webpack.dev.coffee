Extract_plugin = require 'extract-text-webpack-plugin'
Html_plugin = require 'html-webpack-plugin'
merge = require 'webpack-merge'
path = require 'path'
base = require './webpack.base'


module.exports = (module_name) -> merge (base module_name),
  devtool: 'cheap-module-eval-source-map'

  mode: 'development'

  output:
    publicPath: '/'

  devServer:
    historyApiFallback: true
    contentBase: './mocks'
    stats: 'minimal'

  plugins: [
    new Extract_plugin 'style.css'

    new Html_plugin
      template: path.join __dirname, '../mocks/index.html'
  ]

