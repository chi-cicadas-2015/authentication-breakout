get '/' do
  if current_user
    'what up'
  else
    redirect '/sessions/new'
  end
end

get '/users/new' do
  erb :signup
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect '/'
  else
    erb :signup
  end
end

get '/sessions/new' do
  erb :login
end

post '/sessions' do
  if user = User.authenticate(params[:user])
    session[:user_id] = user.id
    redirect '/'
  else
    erb :login
  end
end
  # user = User.find_by(email: params[:email])
  # if user && user.password == params[:password]
