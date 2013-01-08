fs = require 'fs'
path = require 'path'
exec = (require 'child_process').exec
mkdirp = require 'mkdirp'
wrench = require 'wrench'

input =
	server: path.join "src", "server"
	coffee: path.join "src", "client", "app"
	style:  path.join "src", "client", "less"
	vendor: path.join "src", "client", "vendor"
	img:    path.join "src", "client", "img"
	client: path.join "src", "client"

output =
	server: path.join "build", "server"
	js:     path.join "build", "client", "js", "app"
	style:  path.join "build", "client", "css"
	vendor: path.join "build", "client", "js", "vendor"
	img:    path.join "build", "client", "img"
	client: path.join "build", "client"

String::repeat = (n) ->
	return "" if n < 1
	return (new Array n+1).join @

copyFileSync = (srcFile, destFile) ->
  BUF_LENGTH = 64*1024
  buff = new Buffer BUF_LENGTH
  fdr = fs.openSync srcFile, 'r'
  fdw = fs.openSync destFile, 'w'
  bytesRead = 1
  pos = 0
  while bytesRead > 0
    bytesRead = fs.readSync fdr, buff, 0, BUF_LENGTH, pos
    fs.writeSync fdw,buff, 0, bytesRead
    pos += bytesRead
  fs.closeSync fdr
  fs.closeSync fdw

option "-m", "--minify", "Build minified js files"
option "-r", "--rjs", "Compile with r.js optimization"

createDirs = (cont) ->
	for _, outoutPath of output
		mkdirp.sync outoutPath
	cont?()

buildjQuery = (options, cont) ->
	console.log "Building jQuery..."
	cmd = path.join "node_modules", "grunt-cli", "bin", "grunt"
	cwd = path.join input.vendor, "jquery"
	exec cmd, {cwd: cwd}, (error, stdout, stderr) ->
		console.log stderr if stderr
		console.log error if error?
		copyjQuery options, () ->
			cont?()

buildDeps = (options, cont) ->
	console.log "Building dependcies..."
	buildjQuery options, () ->
		copyRequireJs options, () ->
			copyKnockoutJs options, () ->
				copyBootstrapJs options, () ->
					cont?()

copyjQuery = (options, cont) ->
	console.log "Copying jQuery..."
	jqueryInputPath = path.join input.vendor, "jquery", "dist"
	jqueryOutputPath = path.join output.vendor, "jquery"
	mkdirp jqueryOutputPath
	copyFileSync (path.join jqueryInputPath, "jquery.js"), (path.join jqueryOutputPath, "jquery.js")
	cont?()

copyKnockoutJs = (options, cont) ->
	console.log "Copying knockout.js..."
	knockoutInputPath = path.join input.vendor, "knockout"
	knockoutOutputPath = path.join output.vendor, "knockout"
	mkdirp knockoutOutputPath
	copyFileSync (path.join knockoutInputPath, "knockout.js"), (path.join knockoutOutputPath, "knockout.js")
	cont?()

copyRequireJs = (options, cont) ->
	console.log "Copying require.js..."
	requireInputPath = path.join input.vendor, "require"
	requireOutputPath = path.join output.vendor, "require"
	mkdirp requireOutputPath
	copyFileSync (path.join requireInputPath, "require.js"), (path.join requireOutputPath, "require.js")
	cont?()

copyBootstrapJs = (options, cont) ->
	console.log "Copying bootstrap.js..."
	bootstrapInputPath = path.join input.vendor, "bootstrap"
	bootstrapOutputPath = path.join output.vendor, "bootstrap"
	mkdirp bootstrapOutputPath
	files = fs.readdirSync bootstrapInputPath
	for file in files
		copyFileSync (path.join bootstrapInputPath, file), (path.join bootstrapOutputPath, file)
	cont?()

copyUnderscoreJs = (options, cont) ->
	console.log "Copying underscore.js..."
	underscoreInputPath = path.join input.vendor, "underscore"
	underscoreOutputPath = path.join output.vendor, "underscore"
	mkdirp underscoreOutputPath
	copyFileSync (path.join underscoreInputPath, "underscore.js"), (path.join underscoreOutputPath, "underscore.js")

copyHtml = (options, cont) ->
	console.log "Copying templates..."
	inputIndex = path.join input.client, "app"
	outputIndex = path.join output.client
	copyFileSync (path.join inputIndex, "index.html"), (path.join outputIndex, "index.html")
	cont?()

compileLess = (options, cont) ->
	console.log "Compiling less..."
	inputFile = path.join input.style, "style.less"
	outputFile = path.join output.style, "style.css"
	exec "lessc -O2 #{inputFile} #{outputFile}", (error, stdout, stderr) ->
		console.log stderr if stderr
		console.log error if error?
		cont?()

copyingImages = (options, cont) ->
	console.log "Copying images..."
	wrench.copyDirSyncRecursive input.img, output.img
	cont?()

buildServer = (options, cont) ->
	console.log "Compiling server..."
	exec "coffee --compile --bare --output #{output.server} #{input.server}", (error, stdout, stderr) ->
		console.log stderr if stderr
		console.log error if error?
		cont?()

buildClient = (options, cont) ->
	console.log "Compiling client..."
	exec "coffee --compile --bare --output #{output.js} #{input.coffee}", (error, stdout, stderr) ->
		console.log stderr if stderr
		console.log error if error?
		compileLess options, () ->
			copyingImages options, () ->
				copyHtml options, () ->
					cont?()

buildApp = (options, cont) ->
	buildServer options, () ->
		buildClient options, () ->
			cont?()

buildAll = (options, cont) ->
	buildDeps options, () ->
		buildApp options, () ->
			cont?()

cleanServer = (options, cont) ->
	console.log "Cleaning server..."
	wrench.rmdirSyncRecursive output.server
	cont?()

cleanClient = (options, cont) ->
	console.log "Cleaning client..."
	wrench.rmdirSyncRecursive output.client
	cont?()

task 'build:all', (options) ->
	createDirs () ->
		buildAll options, () -> return

task "build:deps", (options) ->
	createDirs () ->
		buildDeps options, () -> return

task "build:jquery", (options) ->
	createDirs () ->
		buildjQuery options, () -> return

task "build:app", (options) ->
	createDirs () ->
		buildApp options, () -> return

task "build:server", (options) ->
	createDirs () ->
		buildServer options, () -> return

task "build:client", (options) ->
	createDirs () ->
		buildClient options, () -> return

task "clean:server", (options) ->
	cleanServer options, () -> return

task "clean:client", (options) ->
	cleanClient options, () -> return

task "clean:all", (options) ->
	cleanServer options, () ->
		cleanClient options, () -> return