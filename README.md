# Developing insructions #
You need nodejs and some global npm packages installed.

		npm install -g coffee-script
		npm install -g less

## Getting started ##
First clone the project:

		git://github.com/thetrompf/xbmc-web-interface.git

The checkout the directory, and install node dependencies:

		cd xbmc-web-interface
		npm install

Then you need to build the project for the first time:

		cake build:all

Start the server with a watcher on, watching if something changes in the build/server directory:

		npm run-script watch

For the watching functionality, you have to have nodemon installed in you path:

		npm install -g nodemon

For usage without the wathcer run:

		npm start

For developing the client, run this for only building the client:

		cake build:client

For more instructions, for e.g. cleaning directories and building different parts of the project, simply run:

		cake