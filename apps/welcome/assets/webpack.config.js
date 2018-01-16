var path = require('path')
var webpack = require('webpack')
var env = process.env.MIX_ENV || 'dev'

const RewriteImportPlugin = require("less-plugin-rewrite-import");
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ROOT_DIR = path.resolve(__dirname);
const SRC_DIR = path.resolve(__dirname, '../priv/static/');
const BUILD_DIR = path.resolve(__dirname, 'build');
const NODE_MODULES_DIR = path.resolve(__dirname, 'node_modules');

module.exports = {
  entry: {
    'app': __dirname + '/js/app.js'
  },
  output: {
    path: path.resolve(__dirname, '../priv/static/'),
    filename: 'js/[name].js'
  },
  devtool: 'source-map',
  resolve: {
    // extensions: ['.js', '.jsx'],
    modules: [path.resolve(__dirname), 'node_modules'],
    alias: {
      jquery: path.resolve(__dirname, 'node_modules/jquery/src/jquery')
    }
  },
  module: {
    loaders: [
      {
        test: /\.(less|config)$/,
        use: [
          'style-loader',
          'css-loader',
          {
            loader: 'less-loader',
            options: {
              paths: [ROOT_DIR, NODE_MODULES_DIR],
              plugins: [
                new RewriteImportPlugin({
                  paths: {
                    '../../theme.config':  __dirname + '/css/theme.config',
                  },
                }),
              ],
            }
          }
        ]
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "file-loader",
        query: {
          name: "fonts/[hash].[ext]",
          mimetype: "application/font-woff"
        }
      },
      {
        test: /\.(eot|svg|ttf)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "file-loader",
        query: {
          name: "fonts/[hash].[ext]"
        }
      },
      {
        test: /\.(png)$/,
        loader: "file-loader",
        query: {
          name: "images/[hash].[ext]"
        }
      },
      {
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel-loader',
        query: {presets: ['es2015']}
      },
      { 
		test: /\.eex/, 
		loader: 'ejs-loader' 
	  }
    ]
  },
  plugins: [
	new HtmlWebpackPlugin({
      template: '../lib/welcome_web/templates/layout/app.html.eex',
	  filename: 'app.html.eex',
	  inject: 'body', // inject scripts before closing body tag
      env: process.env
	}),
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      "window.jQuery": "jquery"
    })
  ]
};
