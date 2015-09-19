#!/usr/bin/env ruby
require 'sinatra'
require 'json'



SERVING_URL = ENV['serving_url']
PASS = ENV['PASS']
HASH_SET = {}


# get "/test_endpoint" do
# 	counter = 0
# 	while 1>0
# 		HASH_SET["test"+counter.to_s] = "https://hq.appsflyer.com/id577586159/report#/2015-09-13/2015-09-20"
# 		counter += 1
# 		puts HASH_SET.length
# 	end 
# 	status 200
# end

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

post "/add/" do
	json_params = JSON.parse(request.body.read.to_s)
	if json_params['pwd'] != PASS
		status 401
	else
		HASH_SET[json_params['short']] = json_params["url"]
		puts json_params['short'] + " " + HASH_SET[json_params['short']] + " " + HASH_SET.length.to_s
		response = {}
		response['url'] = SERVING_URL + json_params['short']
		response['redir'] = HASH_SET[json_params['short']]
		response['size'] = HASH_SET.length
		status 200
		response.to_json	
	end
	
end


