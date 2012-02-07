require 'octokit'
require 'sinatra'

configure do
  set :gh_user, ENV["GH_USER"] || "your_user"
  set :gh_password, ENV["GH_PASSWORD"] || "your_password"
  set :basic_user, ENV["BASIC_USER"] || "admin"
  set :basic_password, ENV["BASIC_PASSWORD"] || "your_password"
end


use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == [settings.basic_user, settings.basic_password]
end

$ghcli = Octokit::Client.new :login => settings.gh_user , :password => settings.gh_password

helpers do
  def fetch_issues(reponame)
    issues = []
    page = 0
    begin
      issues << $ghcli.list_issues( reponame, :page => page, :state => :open )
      page += 1
    end until issues[-1].length != 10
    issues.flatten
  end
end

# Sinatra Routes
get '/issues/*' do |reponame|
  @reponame = reponame
  @issues = fetch_issues reponame
  nokogiri :issues
end
