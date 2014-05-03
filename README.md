# Purpose #

This project serves as a template to jumpstart the development of new application with NodeJS + Express in CoffeeScript.

# Technologies

### Backend

* NodeJS
* Jade - server-side templating engine
* Less - css alternative (autocompiled to CSS on request)
* MongoDB - connectors to MongoDB database

### Frontend

* AngularJS
* AngularJS - Route Module
* AngularJS - Resource Module
* Bootstrap
* UI Bootstrap for AngularJS
* Spacelab Bootstrap Theme

# Requirements

Build tools require your system to have `coffee` and `node` programs on your PATH. 

# Usage

Clone the repository and remove `.git` folder. Run `npm install` to download all node libraries.

You will then probably want to edit the `package.json` file.

Command to run the CoffeeScript compilator:

> jake compiler:run

Command to build project and run the NodeJS server:

> jake server:run


# About Testing...

You can see that the Jakefile.js contains a task for testing the code with BusterJS and there is `buster.coffee` config file. This is currently not supported - not until I know what I'm doing with BusterJS :) It's here because I hope that in the future I'll know how to setup all the required pieces.
