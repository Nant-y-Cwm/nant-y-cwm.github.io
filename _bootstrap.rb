require_relative '_modules/FBEvents.rb'

root = File.expand_path(File.dirname(__FILE__))

ScmsUtils.log( "<div class='alert alert-info'><h4>Running Bootstrapper</h4></div>" )

#Get FB Events
group_id = "124914354200526"
app_id = "1406742256221468"
app_secret = "b0faaf76456d30d04609779a4d8be0e9"
event_view_resource = File.join($website, "_resources", "events.yml")

begin 
	if $watch
    	puts "Skipping calendar scrape while in watch mode"
    else
    	FBEvents.get(group_id, app_id, app_secret, event_view_resource)  if !$cmsmode
	end
rescue Exception => e  
    puts "Error getting Facebook events"
	puts e.message  
    puts e.backtrace.inspect  
end
