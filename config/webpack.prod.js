////////////////////////////////////////////////////////////////////////////////
// FILE: webpack.prod.js
// AUTHOR: David Ruvolo
// CREATED: 2020-09-30
// MODIFIED: 2020-09-30
// PURPOSE: configuration for production env
// DEPENDENCIES: see below + common
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// load
const TerserPlugin = require("terser-webpack-plugin");
const OptimizeCssAssetsPlugin = require("optimize-css-assets-webpack-plugin");

// config
module.exports = {
    mode: "production",
    optimization: {
        minimize: true,
        minimizer: [
            new OptimizeCssAssetsPlugin({
                cssProcessor: require("cssnano"),
            }),
            new TerserPlugin()
        ]
    },
}