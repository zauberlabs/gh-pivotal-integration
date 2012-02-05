require 'octokit'
require 'sinatra'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['admin', 'zauberlabs']
end

$ghcli = Octokit::Client.new :login => "mcortesi" , :password => "password!"

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

