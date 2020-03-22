process.env.NODE_ENV = process.env.NODE_ENV || 'development'
process.env.CODE_VERSION = process.env.CODE_VERSION || 'develop'

const environment = require('./environment')
module.exports = environment.toWebpackConfig()
