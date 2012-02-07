require 'octokit'
require 'sinatra'

configure do
  set :gh_user, "mcortesi"
  set :gh_password, "password here"
  set :basic_user, 'admin'
  set :basic_password, 'zauberlabs'
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
