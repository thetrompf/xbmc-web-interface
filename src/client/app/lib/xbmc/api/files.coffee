define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Files
	###
	class Files extends APIBase

		###
		# Downloads the given file.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Files.
		#
		# @var string path
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback any
		# @return APIBase
		###
		Download: (options) ->
			method = "#{@_API}.Download"
			return @
			
		###
		# Get the directories and files in the given directory.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Files.GetDirectory
		#
		# @var string directory
		# @var [ Files.Media media = "files" ]
		# @var [ List.Fields.Files properties ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, List.Item.File[] files }
		# @return APIBase
		###
		GetDirectory: (options) ->
			method = "#{@_API}.GetDirectory"
			return @
			
		###
		# Get details for a specific file.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Files.GetFileDetails
		#
		# @var string file
		# @var [ Files.Media media = "files" ]
		# @var [ List.Fields.Files properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.Item.File filedetails }
		# @return APIBase
		###
		GetFileDetails: (options) ->
			method = "#{@_API}.GetFileDetails"
			return @
			
		###
		# Get the sources of the media windows.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Files.GetSources
		#
		# @var Files.Media media
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, List.Items.Sources sources }
		# @return APIBase
		###
		GetSources: (options) ->
			method = "#{@_API}.GetSources"
			return @
			
		###
		# Provides a way to download a given file (e.g. providing an URL to the real file location).
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Files.PrepareDownload
		#
		# @var string path
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { string mode, string protocol, any details }
		# @return APIBase
		###
		PrepareDownload: (options) ->
			method = "#{@_API}.PrepareDownload"
			return @
			