////////////////////////////////////////////////////////////////////////////////
// FILE: webpack.config.js
// AUTHOR: David Ruvolo
// CREATED: 2020-09-30
// MODIFIED: 2021-01-19
// PURPOSE: main webpack config; uses --env arg in CLI
// DEPENDENCIES: see below + common
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// pkgs
const { merge } = require("webpack-merge");
const commonConfig = require("./config/webpack.common");

// load config based on environment
module.exports = (env) => {
    const e = env.prod ? "prod" : "dev";
    const config = require("./config/webpack." + e);
    return merge(commonConfig, config);
}
