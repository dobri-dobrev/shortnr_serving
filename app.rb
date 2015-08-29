require 'sinatra'
require 'json'


HASH_SET = {
	"yhoo" => "http://www.yahoo.com",
	"goog" => "http://www.google.com"
}

get "/" do
	content_type :json
	"hello there!".to_json
end

get "/:addr" do
	if HASH_SET[params["addr"]].nil?
		status 404
	else
		redirect HASH_SET[params["addr"]]
	end
end 

post "/secret_place/" do
	json_params = JSON.parse(request.body.read.to_s)
	HASH_SET[json_params['short']] = json_params["url"]
	status 200
end

