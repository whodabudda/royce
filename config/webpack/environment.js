const { environment } = require('@rails/webpacker')

const path = require( 'path' );
const webpack = require('webpack')
//environment.loaders.prepend('erb', erb)
//const erb = require('./loaders/erb')
const WebpackAssetsManifest = require('webpack-assets-manifest');
// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader',
});

environment.config.merge({
  module: {
    rules: [
      {
        test: require.resolve('jquery'),
        use: [{
          loader: 'expose-loader',
          options: '$'
        }, {
          loader: 'expose-loader',
          options: 'jQuery'
        }]
      }
          ]
  }
});
environment.splitChunks()
//svgRule.uses.clear();  // probably needed if using Vue
// end of ppk add ckeditor

module.exports = environment

