const nanoid = require("nanoid");
process.env.NODE_ENV = process.env.NODE_ENV || 'production'
process.env.CODE_VERSION = process.env.CODE_VERSION || nanoid()

const environment = require('./environment')
module.exports = environment.toWebpackConfig()
