## 概念

webpack是一个现代javascript应用程序的模块打包器。

当webpack处理你的应用程序时，它会递归构建一个依赖图（包含了你的应用程序所需要每个模块），然后把这些模块打包到少数几个budle文件中（通常是只有一个，会被浏览器加载，根据项目情况而定）。

这是令人难以置信的配置，但开始前，你只需要明白四个核心概念：entry、output、loaders、和plugins。

**配置对象选项**
**webpack.config.js模板**

```
const path = require('path');

module.exports = {
  // click on the name of the option to get to the detailed documentation
  // click on the items with arrows to show more examples / advanced options

  entry: "./app/entry", // string | object | array
  // Here the application starts executing
  // and webpack starts bundling

  output: {
    // options related to how webpack emits results

    path: path.resolve(__dirname, "dist"), // string
    // the target directory for all output files
    // must be an absolute path (use the Node.js path module)

    filename: "bundle.js", // string
    // the filename template for entry chunks

    publicPath: "/assets/", // string
    // the url to the output directory resolved relative to the HTML page

    library: "MyLibrary", // string,
    // the name of the exported library

    libraryTarget: "umd", // universal module definition
    // the type of the exported library

    /* Advanced output configuration (click to show) */
  },

  module: {
    // configuration regarding modules

    rules: [
      // rules for modules (configure loaders, parser options, etc.)

      {
        test: /\.jsx?$/,
        include: [
          path.resolve(__dirname, "app")
        ],
        exclude: [
          path.resolve(__dirname, "app/demo-files")
        ],
        // these are matching conditions, each accepting a regular expression or string
        // test and include have the same behavior, both must be matched
        // exclude must not be matched (takes preferrence over test and include)
        // Best practices:
        // - Use RegExp only in test and for filename matching
        // - Use arrays of absolute paths in include and exclude
        // - Try to avoid exclude and prefer include

        issuer: { test, include, exclude },
        // conditions for the issuer (the origin of the import)

        enforce: "pre",
        enforce: "post",
        // flags to apply these rules, even if they are overridden (advanced option)

        loader: "babel-loader",
        // the loader which should be applied, it'll be resolved relative to the context
        // -loader suffix is no longer optional in webpack2 for clarity reasons
        // see webpack 1 upgrade guide

        options: {
          presets: ["es2015"]
        },
        // options for the loader
      },

      {
        test: "\.html$",

        use: [
          // apply multiple loaders and options
          "htmllint-loader",
          {
            loader: "html-loader",
            options: {
              /* ... */
            }
          }
        ]
      },

      { oneOf: [ /* rules */ ] },
      // only use one of these nested rules

      { rules: [ /* rules */ ] },
      // use all of these nested rules (combine with conditions to be useful)

      { resource: { and: [ /* conditions */ ] } },
      // matches only if all conditions are matched

      { resource: { or: [ /* conditions */ ] } },
      { resource: [ /* conditions */ ] },
      // matches if any condition is matched (default for arrays)

      { resource: { not: /* condition */ } }
      // matches if the condition is not matched
    ],

    /* Advanced module configuration (click to show) */
  },

  resolve: {
    // options for resolving module requests
    // (does not apply to resolving to loaders)

    modules: [
      "node_modules",
      path.resolve(__dirname, "app")
    ],
    // directories where to look for modules

    extensions: [".js", ".json", ".jsx", ".css"],
    // extensions that are used

    alias: {
      // a list of module name aliases

      "module": "new-module",
      // alias "module" -> "new-module" and "module/path/file" -> "new-module/path/file"

      "only-module$": "new-module",
      // alias "only-module" -> "new-module", but not "module/path/file" -> "new-module/path/file"

      "module": path.resolve(__dirname, "app/third/module.js"),
      // alias "module" -> "./app/third/module.js" and "module/file" results in error
      // modules aliases are imported relative to the current context
    },
    /* alternative alias syntax (click to show) */

    /* Advanced resolve configuration (click to show) */
  },

  performance: {
    hints: "warning", // enum
    maxAssetSize: 200000, // int (in bytes),
    maxEntrypointSize: 400000, // int (in bytes)
    assetFilter: function(assetFilename) {
      // Function predicate that provides asset filenames
      return assetFilename.endsWith('.css') || assetFilename.endsWith('.js');
    }
  },

  devtool: "source-map", // enum
  // enhance debugging by adding meta info for the browser devtools
  // source-map most detailed at the expense of build speed.

  context: __dirname, // string (absolute path!)
  // the home directory for webpack
  // the entry and module.rules.loader option
  //   is resolved relative to this directory

  target: "web", // enum
  // the environment in which the bundle should run
  // changes chunk loading behavior and available modules

  externals: ["react", /^@angular\//],
  // Don't follow/bundle these modules, but request them at runtime from the environment

  stats: "errors-only",
  // lets you precisely control what bundle information gets displayed

  devServer: {
    proxy: { // proxy URLs to backend development server
      '/api': 'http://localhost:3000'
    },
    contentBase: path.join(__dirname, 'public'), // boolean | string | array, static file location
    compress: true, // enable gzip compression
    historyApiFallback: true, // true for index.html upon 404, object for multiple paths
    hot: true, // hot module replacement. Depends on HotModuleReplacementPlugin
    https: false, // true for self-signed, object for cert authority
    noInfo: true, // only errors & warns on hot reload
    // ...
  },

  plugins: [
    // ...
  ],
  // list of additional plugins


  /* Advanced configuration (click to show) */
}
```

本文档的目的是给这些概念提供一个高层次的大纲，同时提供链接给详细概念的指定用例。

##  Entry

webpack会创建一个你所有应用程序的依赖图。这个依赖图的起始点就是已知的entry（入口）点。这个入口点告诉webpack从哪开始，并且根据已知依赖图进行打包。你可以把应用程序的入口点当作上下文根或启动你的应用程序的第一个文件。

在webpack配置对象的entry属性中定义入口点。简单示例如下：

```
module.exports = {
  entry: './path/to/my/entry/file.js'
};
```

**有几种方式声明entry属性：**

1、单个entry语法
```
const config = {
  entry: './path/to/my/entry/file.js'
};

module.exports = config;
```

2、对象语法
```
const config = {
  entry: {
    app: './src/app.js',
    vendors: './src/vendors.js'
  }
};
```

3、多页面应用
```
const config = {
  entry: {
    pageOne: './src/pageOne/index.js',
    pageTwo: './src/pageTwo/index.js',
    pageThree: './src/pageThree/index.js'
  }
};
```

## Output
一旦你打包所有代码，你仍需要告诉webpack打包到哪里去。output属性会告诉webpack如何对待你的代码。
```
const path = require('path');

module.exports = {
  entry: './path/to/my/entry/file.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'my-first-webpack.bundle.js'
  }
};
```
以上这个例子，我们使用` output.filename `和` output.path `属性告诉webpack打包的文件名和路径

[更多配置项](https://webpack.js.org/configuration/output/)

## Loaders
这个配置项的目的是让webpack关注你项目的所有代码而非浏览器（这并不意味着它们会被打包到一起）。webpack把每一个文件（.css, .html, .scss, .jpg, etc.）作为一个模块。然而，webpack只知道javascript。

webpack中的Loaders会转换这些文件到模块中，并添加到你的依赖图中。

在一个较高的水平，在你的webpack配置中有两个目的：
1、标识什么文件应该用一个确定的loader来转换。
2、转换后的文件可以被添加到你的依赖图中。

```
const path = require('path');

const config = {
  entry: './path/to/my/entry/file.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'my-first-webpack.bundle.js'
  },
  module: {
    rules: [
      {test: /\.(js|jsx)$/, use: 'babel-loader'}
    ]
  }
};

module.exports = config;
```
以上这个配置定义了一个rulues属性，用以给一个单独的模块，这个模块带有两个属性：test和use。这告诉webpack编译如下事情：
当使用require()或import语句时，路径中后缀名为.js或.jsx的文件，使用babel-loader来转换并打包。

[更多配置项](https://webpack.js.org/concepts/loaders/)

## Plugins
因为加载器只执行基于每个文件的转换，插件是最常用的（但不限于）优化行为，并且你可以自定义函数在你打包模块的编辑或块中（等等）。
该webpack插件系统极其强大，可定制。

为了使用一个插件，你只需要require()并添加到插件数组中。更多插件可通过选项自定义。由于你可以在一个配置中多次使用插件来达到不同的目的，因此你需要创建一个新的实例。
```
const HtmlWebpackPlugin = require('html-webpack-plugin'); //installed via npm
const webpack = require('webpack'); //to access built-in plugins
const path = require('path');

const config = {
  entry: './path/to/my/entry/file.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'my-first-webpack.bundle.js'
  },
  module: {
    rules: [
      {test: /\.txt$/, use: 'raw-loader'}
    ]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin(),
    new HtmlWebpackPlugin({template: './src/index.html'})
  ]
};

module.exports = config;
```
webpack提供有许多开箱插件！可以从我们的[插件列表]((https://webpack.js.org/plugins/))中获得更多信息。

在webpack配置中使用插件是简单的，然而有许多用法值得进一步探讨。

[更多配置项](https://webpack.js.org/concepts/plugins/)

## Configuration


## Modules


## Module Resolution


## Dependency Graph


## The Manifest


## Targets


## Hot Module Replacement