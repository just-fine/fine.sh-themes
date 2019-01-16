path = require 'path'
merge = require 'webpack-merge'
base = require './webpack.base'
Extract_plugin = require 'extract-text-webpack-plugin'
Optimize_plugin = require 'optimize-css-assets-webpack-plugin'


module.exports = (module_name) -> merge (base module_name),
  devtool: 'eval'

  output:
    filename: '[name].css'
    path: path.join __dirname, '../dist'

  mode: 'production'

  plugins: [
    new Extract_plugin '[name].css'

    new Optimize_plugin
      assetNameRegExp: /\.css\.*(?!.*map)/g
      cssProcessor: require 'cssnano'
      cssProcessorOptions:
        discardComments:
          removeAll: on
        safe: on
        autoprefixer: off
  ]
