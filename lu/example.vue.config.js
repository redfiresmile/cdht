const path = require('path')
const fs = require('fs')

const resolve = dir => {
  return path.join(__dirname, dir)
}

const luOutPath = '../'

const env = process.env.NODE_ENV || 'development'
fs.writeFileSync(path.join(__dirname, './config/env.js'), `export default '${env}'
`)

const BASE_URL = env === 'development'
  // ? '/localhost-test/'
  ? ''
  : 'https://lucms.com/lu/dist/'

module.exports = {
  baseUrl: BASE_URL,
  outputDir: luOutPath + 'public/lu/dist',
  indexPath: luOutPath + '../../resources/views/dashboard.blade.php',
  chainWebpack: config => {
    config.resolve.alias.set('@', resolve('src')). // key,value自行定义，比如.set('@@', resolve('src/components'))
    set('_c', resolve('src/components')).set('_conf', resolve('config'))
  },
  productionSourceMap: false
}
