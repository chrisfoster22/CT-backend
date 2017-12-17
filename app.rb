require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'sinatra/cross_origin'
require 's3/authorize'

s3_authorize = S3::Authorize.new(bucket: 'paperclip-matteo', acl: 'public-read', 'secret_key': 'DSOAVTNSW7uebeAMJRQQDVxs7+YiyquivQMnrJ1X')
# AKIAIYAHGVMXFE4TCY5A
# DSOAVTNSW7uebeAMJRQQDVxs7+YiyquivQMnrJ1X

set :database, 'sqlite3:app.sqlite3'
set :sessions, true

require './models'

configure do
	enable :cross_origin
end
before do
	response.headers['Access-Control-Allow-Origin'] = '*'
end

get '/' do
	@awacts = Awact.all
	content_type :json
	@awacts.to_json
end

post '/awacts' do 
	@json = JSON.parse(request.body.read)['body']
	@json = JSON.parse(@json)
	@awact = Awact.create(creator_id: 1, title: @json['title'], body: @json['description'], event_time: @json['event_time'].to_datetime, location: @json['location'])
	@awact.to_json
end

post '/awacts/start' do
	@json = JSON.parse(request.body.read)['body']
	@json = JSON.parse(@json)
	@awact = Awact.where(id: @json['awact_id'])
	@awact.update(in_progress: true, participant_id: 1)
end

post '/awacts/complete' do
	@json = JSON.parse(request.body.read)['body']
	@json = JSON.parse(@json)
	@awact = Awact.where(id: @json['awact_id'])
	@awact.update(completed: true, participant_id: 1)
end

get '/users/:id' do 
	@user = User.where(id: params["id"]).first
	@completed_awacts = Awact.where(participant_id: params["id"], completed: true)
	@in_progress_awacts = Awact.where(participant_id: params["id"], completed: nil)
	@data = {user: @user, completed_awacts: @completed_awacts, in_progress_awacts: @in_progress_awacts}
	@data.to_json
end

post '/login' do
	user = User.where(username: params[:username]).first
	if user.password == params[:password]
		session[:user_id] = user.id
		redirect '/'
	else
		redirect '/'
	end
end

get '/generate-signature' do 
	s3_policy = s3_authorize.policy 
	s3_signature = s3_authorize.signature(s3_policy)
	content_type :json
	{sig: s3_signature}.to_json
end

options "*" do
	response.headers["Allow"] = "GET, POST, OPTIONS"
	response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
	response.headers["Access-Control-Allow-Origin"] = "*"
	200
end
#
