fs = require 'fs'
path = require 'path'
exec = (require 'child_process').exec
mkdirp = require 'mkdirp'
wrench = require 'wrench'
_ = require 'underscore'

input =
	server: path.join "src", "server"
	app:    path.join "src", "client", "app"
	base:   path.join "src", "client", "base"
	style:  path.join "src", "client", "less"
	vendor: path.join "src", "client", "vendor"
	img:    path.join "src", "client", "img"
	client: path.join "src", "client"

output =
	server: path.join "build", "server"
	app:    path.join "build", "client", "js", "app"
	base:   path.join "build", "client", "js", "base"
	style:  path.join "build", "client", "css"
	vendor: path.join "build", "client", "js", "vendor"
	img:    path.join "build", "client", "img"
	client: path.join "build", "client"

String::repeat = (n) ->
	return "" if n < 1
	return (new Array n+1).join @

copyFile = (srcFile, destFile, cont) ->
	src = fs.createReadStream srcFile
	dest = fs.createWriteStream destFile

	src.pipe dest
	dest.on 'close', () ->
		cont?()

copyFileSync = (srcFile, destFile) ->
	console.log srcFile, destFile
	BUF_LENGTH = 128*1024
	buff = new Buffer BUF_LENGTH
	fdw = fs.openSync destFile, 'w'
	console.log "opened write"
	fdr = fs.openSync srcFile, 'r'
	bytesRead = 1
	pos = 0
	while bytesRead > 0
		bytesRead = fs.readSync fdr, buff, 0, BUF_LENGTH, pos
		fs.writeSync fdw,buff, 0, bytesRead
		pos += bytesRead
	fs.closeSync fdw
	fs.closeSync fdr

# ext is optional
fs.find = (dir, ext, done) ->
	# checking if ext is present
	done = ext if _.isFunction ext
	results = []
	fs.readdir dir, (err, list) ->
		return done err if err
		i = 0
		(next = () ->
			file = list[i++]
			return done null, results unless file
			file = path.join dir, file
			fs.stat file, (err, stat) ->
				if stat and stat.isDirectory()
					if _.isString ext
						fs.find file, ext, (err, res) ->
							results = results.concat res
							next()
					else
						fs.find file, (err, res) ->
							results = results.concat res
							next()
				else
					if _.isString ext # check if extension is defined
						fileExt = path.extname file
						results.push file if fileExt is ".#{ext}"
					else
						results.push file
					next()
		)()

option "-m", "--minify", "Build minified js files"
option "-r", "--rjs", "Compile with r.js optimization"

createDirs = (cont) ->
	for unused, outoutPath of output
		mkdirp.sync outoutPath
	cont?()

copyDeps = (options, cont) ->
	console.log "Copying dependcies..."
	inputIndex = path.join input.vendor
	outputIndex = path.join output.vendor

	mkdirp outputIndex, () ->
		fs.find inputIndex, "js", (err, files) ->
			return cont?() if err?
			i = 0
			(next = (cont) ->
				filePath = files[i++]
				return cont?() unless filePath?

				cp = () ->
					file = path.basename filePath
					copyFile filePath, (path.join outputIndex, dir, file), () ->
						next(cont)

				dir = (path.dirname filePath).substring (inputIndex.length + 1)
				if dir isnt ""
					mkdirp (path.join outputIndex, dir), () ->
						cp()
				else
					cp()

			)(cont)

copyHtml = (options, cont) ->
	console.log "Copying templates..."
	inputIndex = path.join input.app
	outputIndex = path.join output.app

	mkdirp outputIndex, () ->
		copyFile (path.join inputIndex, "index.html"), (path.join outputIndex, "index.html"), () ->

			fs.find inputIndex, "html", (err, files) ->
				return cont?() if err?
				i = 0
				(next = (cont) ->
					filePath = files[i++]
					return cont?() unless filePath?

					cp = () ->
						file = path.basename filePath
						copyFile filePath, (path.join outputIndex, dir, file), () ->
							next(cont)

					dir = (path.dirname filePath).substring (inputIndex.length + 1)
					if dir isnt ""
						mkdirp (path.join outputIndex, dir), () ->
							cp()
					else
						cp()

				)(cont)

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
	exec "coffee --compile --bare --output #{output.app} #{input.app}", (error, stdout, stderr) ->
		console.log stderr if stderr
		console.log error if error?
		exec "coffee --compile --bare --output #{output.base} #{input.base}", (error, stdout, stderr) ->
			console.log stderr if stderr
			console.log error if error?
			exec "coffee --compile --bare --output #{output.vendor} #{input.vendor}", (error, stdout, stderr) ->
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
	copyDeps options, () ->
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

task 'build:all', 'Build all', (options) ->
	createDirs () ->
		buildAll options, () -> return

task "build:deps", 'Build dependcies', (options) ->
	createDirs () ->
		copyDeps options, () -> return

task "build:app", 'Build client and server', (options) ->
	createDirs () ->
		buildApp options, () -> return

task "build:server", 'Build server', (options) ->
	createDirs () ->
		buildServer options, () -> return

task "build:client", 'Build client', (options) ->
	createDirs () ->
		buildClient options, () -> return

task "clean:server", 'Clean server', (options) ->
	cleanServer options, () -> return

task "clean:client", 'Clean client', (options) ->
	cleanClient options, () -> return

task "clean:all", 'Clean all', (options) ->
	cleanServer options, () ->
		cleanClient options, () -> return
