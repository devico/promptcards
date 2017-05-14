module.exports = {
  test: /\.js(\.erb)?$/,
  exclude: /node_modules/,
  use: {
    loader: 'babel-loader',
    options: {
      presets: ['env'],
      plugins: [require('babel-plugin-transform-object-rest-spread')]
    }
  }

}
