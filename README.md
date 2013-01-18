# Developing instructions #
You need nodejs and some global npm packages installed.

		npm install -g coffee-script less nodemon

## Getting started ##
First clone the project:

		git://github.com/thetrompf/xbmc-web-interface.git

Then checkout the directory, and install the node dependencies:

		cd xbmc-web-interface
		npm install

Now you need to build the project for the first time:

		cake build:all

Start the server with a watcher on, watching if something changes in the build/server directory:

		npm run-script watch

For usage without the wathcer, run:

		npm start

For developing the client, run this for only building the client:

		cake build:client

For more instructions, e.g. about cleaning directories and building different parts of the project, simply run:

		cake
