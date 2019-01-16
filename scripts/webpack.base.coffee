fs = require 'fs'
path = require 'path'
Extract_plugin = require 'extract-text-webpack-plugin'
themes_path = path.join __dirname, '../themes'

all_modules = ->
  modules = fs.readdirSync themes_path
  make_path = (tar) -> path.join themes_path, tar
  map = {}
  map[dir] = path.join (make_path dir), 'index.styl' for dir in modules \
    when do (fs.statSync make_path dir).isDirectory
  map

target_module = (dir) ->
  full = path.join themes_path, dir
  file = path.join full, 'index.styl'
  if not fs.existsSync full or not fs.existsSync file
    console.log "#{dir} module not found."
    process.exit 1
  "#{dir}": file

make_entrys = (module_name) ->
  (module_name is 'all' and do all_modules) or target_module module_name


module.exports = (module_name) ->
  entry: make_entrys module_name

  devtool: 'source-map'

  resolve:
    extensions: ['.js', '.css', '.styl', '.png']

  module:
    rules: [
      {
        test: /\.css$/
        exclude: /examples/
        use: [
          'style-loader'
          'css-loader'
        ]
      }
      {
        test: /\.styl$/
        use: Extract_plugin.extract
          fallback: 'style-loader'
          use: [
            'css-loader'
            'stylus-loader'
          ]
      }
      {
        test: /\.(png|jpe?g|gif|svg|woff|woff2|ttf|eot|ico)$/
        use: [
          'url-loader?name=assets/[name].[hash].[ext]'
        ]
      }
    ]


