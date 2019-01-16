{ execSync } = require 'child_process'
fs = require 'fs'
path = require 'path'
webpack = require 'webpack'
inquirer = require 'inquirer'
dev_server = require 'webpack-dev-server'
dev_configs = require './scripts/webpack.dev'
prod_configs = require './scripts/webpack.prod'

make_promps = (themes) ->
  [{
    choices: ({ name, value: name } for name in themes),
    type: 'list'
    name: 'module'
    message: 'please select a module'
  }]

task 'start', 'lift a dev server', ->
  themes = String execSync 'ls -l ./themes |awk \'/^d/ {print $NF}\''
    .split '\n'
    .filter (r) -> r
  { module } = await inquirer.prompt make_promps themes

  configs = dev_configs module
  compiler = webpack configs
  options = Object.assign {}, configs.devServer, { stats: colors: on }
  new dev_server compiler, options
    .listen 4001, 'localhost', ->
      console.log 'starting server on http://localhost:4001'


task 'build', 'build bundle', ->
  execSync 'rm -rf ./dist'
  configs = prod_configs 'all'
  webpack configs, (err, stats) ->
    if err is yes
      console.error stats?.error
      console.error stats.details if stats.details is yes
      process.exit 1
    console.log stats.toString
      colors: true
