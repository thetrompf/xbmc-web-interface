define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR
	###
	class PVR extends APIBase

		###
		# Retrieves the details of a specific channel.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR.GetChannelDetails
		#
		# @var Library.Id channelid
		# @var [ PVR.Fields.Channel properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ PVR.Details.Channel channeldetails ] } 
		# @return APIBase
		###
		GetChannelDetails: (options) ->
			method = "#{@_API}.GetChannelDetails"
			return @

		###
		# Retrieves the details of a specific channel group.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR.GetChannelGroupDetails
		#
		# @var PVR.ChannelGroup.Id channelgroupid
		# @var [ object channels ]
		#          [ List.Limits limits ]
		#          [ PVR.Fields.Channel properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ PVR.Details.ChannelGroup.Extended channelgroupdetails ] }
		# @return APIBase
		###
		GetChannelGroupDetails: (options) ->
			method = "#{@_API}.GetChannelGroupDetails"
			return @

		###
		# Retrieves the channel groups for the specified type.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR.GetChannelGroups
		#
		# @var PVR.Channel.Type channeltype
		# @var [ List.Limits limits ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, PVR.Details.ChannelGroup[] channelgroups }
		# @return APIBase
		###
		GetChannelGroups: (options) ->
			method = "#{@_API}.GetChannelGroups"
			return @

		###
		# Retrieves the channel list.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR.GetChannels
		#
		# @var PVR.ChannelGroup.Id channelgroupid
		# @var [ PVR.Fields.Channel properties ]
		# @var [ List.Limits limits ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, PVR.Details.Channel[] channels }
		# @return APIBase
		###
		GetChannels: (options) ->
			method = "#{@_API}.GetChannels"
			return @

		###
		# Retrieves the values of the given properties.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR.GetProperties
		#
		# @var PVR.Property.Name[] properties
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback PVR.Property.Value
		# @return APIBase
		###
		GetProperties: (options) ->
			method = "#{@_API}.GetProperties"
			return @

		###
		# Toggle recording of a channel.
		# @permission ControlPVR
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR.Record
		#
		# @var [ Global.Toggle record = "toggle" ]
		# @var [ mixed channel = "current" ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Record: (options) ->
			method = "#{@_API}.Record"
			return @

		###
		# Starts a channel scan.
		# @permission ControlPVR
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#PVR.Scan
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Scan: (options) ->
			method = "#{@_API}.Scan"
			return @
