define [
	"underscore"
], (_) ->
	'use strict'
	class Util
		resourceImageSizes = [
			"w45","w92", "w154", "w185","w300","w342", "w500", "w780", "w1280", "original", "h632"
		]

		@parseImageResource = (imageResource, config, size) ->
			stripProtocol = "image://"
			imageResource = @resizeImageResource imageResource, size if size?
			return decodeURIComponent "#{imageResource.substring stripProtocol.length, imageResource.length-1}" unless config.useCached
			resource = config.protocol
			resource += u if (u = config.username)?
			resource += ":#{p}" if (p = config.password)?
			resource += "@" if u?
			resource += h if (h = config.host)?
			resource += ":#{p}" if (p = config.port)?
			resource += "/image/#{imageResource.substring stripProtocol.length, imageResource.length-1}"
			return resource

		@resizeImageResource = (resource, size) ->
			throw new Error "unsupported imagesize: #{size}, supported: #{resourceImageSizes}" unless _.contains resourceImageSizes, size
			return resource.replace "%2foriginal%2f", "%2f#{size}%2f"
