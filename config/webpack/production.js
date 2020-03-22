const nanoid = require("nanoid");
process.env.NODE_ENV = process.env.NODE_ENV || 'production'
process.env.CODE_VERSION = process.env.CODE_VERSION || nanoid()

const environment = require('./environment')

const RollbarSourceMapPlugin = require('rollbar-sourcemap-webpack-plugin')
environment.plugins.insert(
  'Rollbar',
  new RollbarSourceMapPlugin({
    accessToken: process.env.ROLLBAR_ACCESS_TOKEN,
    version: process.env.CODE_VERSION,
    publicPath: 'https://heeeealthy.com/packs',
  })
)

module.exports = environment.toWebpackConfig()
