////////////////////////////////////////////////////////////////////////////////
// FILE: webpack.common.js
// AUTHOR: David Ruvolo
// CREATED: 2020-09-28
// MODIFIED: 2020-09-28
// PURPOSE: configuration to be used in prod and dev
// DEPENDENCIES: see below
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// load
const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyWebpackPlugin = require("copy-webpack-plugin");
const webpack = require("webpack");
const path = require("path");

// configuration
module.exports = {
    entry: "./src/index.js",
    output: {
        filename: "incontrolofeffectsapp.min.js",
        path: path.join(__dirname, "..", "inst/app/www"),
    }  ,
    plugins: [
        new CopyWebpackPlugin({
            patterns: [
                {
                    from: "src/favicon/*.png",
                    to: "[name].[ext]",
                },
                {
                    from: "src/favicon/*.ico",
                    to: "[name].[ext]",
                },
                {
                    from: "src/favicon/site.webmanifest",
                    to: "[name].[ext]",
                }
            ]
        }),
        new webpack.ProgressPlugin(),
        new CleanWebpackPlugin(),
        new MiniCssExtractPlugin({
            filename: "incontrolofeffectsapp.min.css",
            ignoreOrder: false,
        })
    ],
    module: {
        rules: [
            {
                test: /\.js$/,
                use: "babel-loader",
                exclude: /node_modules/,
            },
            {
                test: /\.s[ac]ss$/i,
                use: [
                    // write to file
                    {
                        loader: MiniCssExtractPlugin.loader,
                        options: {
                            publicPath: "./inst/app/www/"
                        }
                    },
                    "css-loader",
                    "postcss-loader",
                    "sass-loader",
                ]
            },
            {
                test: /\.(png|svg|jpg|gif)$/,
                use: [
                    "file-loader"
                ]
            },
        ]
    }
}
