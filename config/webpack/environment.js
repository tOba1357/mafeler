const {environment} = require('@rails/webpacker')
const vue = require('./loaders/vue')
const pug = require('./loaders/pug')
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const webpack = require('webpack')

environment.loaders.append('vue', vue)
environment.loaders.append('pug', pug)
environment.plugins.insert(
  'Vue',
  new VueLoaderPlugin()
)

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery',
    axios: 'axios',
    Vue: 'vue',
    moment: 'moment',
    _: 'lodash',
  })
)
environment.plugins.insert(
  'Define',
  new webpack.DefinePlugin({
    ENV: JSON.stringify(process.env.NODE_ENV),
    CODE_VERSION: JSON.stringify(process.env.CODE_VERSION),
  })
)

const customConfig = require('./custom')
environment.config.merge(customConfig)

module.exports = environment
