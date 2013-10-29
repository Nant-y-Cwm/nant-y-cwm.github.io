module FBEvents
	$: << './'
	require 'open-uri'
	require 'openssl'
	require 'yaml'
	require 'json'
	require 'date'
	
	VERSION = '1.0.0'
	
	def FBEvents.get(group_id, client_id, client_secret, resource)
		ScmsUtils.log( "Getting FaceBook Access Token" )
		access_token = FBEvents.get_access_token(client_id, client_secret)
		ScmsUtils.successLog( access_token )
		ScmsUtils.log( "Getting FaceBook Events" )
		events = FBEvents.get_events(group_id, access_token)
        
		if events != nil && events["data"].length > 0
			ScmsUtils.log( "Getting individual event details" )
			events_resource = FBEvents.load(resource)
			
			if events_resource == FALSE.class
				ScmsUtils.log( "Creating events list" )
				events_resource = Hash.new
			end
			
			events_array = Array.new
			if events_resource != false
				events["data"].sort_by{|start_time|}.reverse.each {|event|	
					start_time = Date.parse(event["start_time"])
					if start_time < Date.today
						puts "Skiping #{event["name"]} because its in the past"
					else
						ScmsUtils.successLog( "#{event["name"]} - start_time: #{start_time.strftime("%d/%m/%Y")}" )
						events_array << FBEvents.get_event(event["id"], access_token)
					end
				}	
			end
			events_resource["events"] = events_array
			FBEvents.save(resource, events_resource)
		else
			puts "No Future Events"
            puts events
		end
	end	

	def FBEvents.get_access_token(client_id, client_secret)
		accessTokenUri = URI.encode("https://graph.facebook.com/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&grant_type=client_credentials")
		accessToken = open(accessTokenUri, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE) {|io| 
			io.read
		}
		return accessToken
	end
	
	def FBEvents.get_events(group_id, accessToken)
        eventsUri = "https://graph.facebook.com/#{group_id}/events?#{accessToken}"
        #puts eventsUri
		eventsUri = URI.encode(eventsUri)
		events = open(eventsUri, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE) {|io| 
			io.read
		}
        
		return JSON.parse(events)
	end
	
	def FBEvents.get_event(event_id, accessToken)	
		eventUri = URI.encode("https://graph.facebook.com/#{event_id}?#{accessToken}")
		event = open(eventUri, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE) {|io| 
			io.read
		}
		return JSON.parse(event)
	end
	
	def FBEvents.save(file_path, hash)
		if hash != nil
			File.open(file_path, "w") {|file| file.puts(hash.to_yaml) }
		else
			ScmsUtils.errLog( "No event data from Facebook" )
		end
	end
	
	def FBEvents.load(file_path)
		yaml = ""
		File.open(file_path, "r") {|file|
			yaml = YAML.load(file)
		}
		return yaml
	end
end
