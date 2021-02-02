const { environment } = require('@rails/webpacker')

module.exports = environment

  // importやrequireなしで$やBootstrapのJavaScriptが使える  
  const webpack = require('webpack')
  environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
      $: 'jquery/src/jquery',
      jQuery: 'jquery/src/jquery',
      Popper: ['popper.js', 'default']
    })
  )
