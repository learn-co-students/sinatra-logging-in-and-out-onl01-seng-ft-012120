require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @session = session
    # get user based on params[:username]
    username = params[:username] #skittles123
    user = User.find_by(username: username)
    # If there is a match, set the session to the user's ID, redirect them to the /account route (using redirect to), 
    # and use ERB to display the user's data on the page.
    if user
      @session[:user_id] = user.id 
      redirect '/account'
    else
      erb :error
    end
  end

  get '/account' do
    @session = session
    if @session[:user_id]
      @user = User.find_by(id: @session[:user_id])
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    @session = session
    session[:user_id] = nil
    redirect '/'
  end


end

