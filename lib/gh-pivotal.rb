require 'octokit'
require 'sinatra'
require 'nokogiri'

configure do
  set :gh_user, ENV["GH_USER"] || "admin"
  set :gh_password, ENV["GH_PASSWORD"] || "admin"
  set :basic_user, ENV["BASIC_USER"] || "admin"
  set :basic_password, ENV["BASIC_PASSWORD"] || "admin"
end

$ghcli = Octokit::Client.new :login => settings.gh_user , :password => settings.gh_password

helpers do
  def fetch_issues(reponame, labels)
    issues = []
    page = 1
    begin
      if not labels.nil?
        issues << $ghcli.list_issues( reponame, :page => page, :state => :open, :labels => labels)
      else
        issues << $ghcli.list_issues( reponame, :page => page, :state => :open )
      end
      page += 1
    end until issues[-1].length == 0
    issues.flatten
  end
  
  def close_issue(issue_xml)
    issue_uri = issue_xml.xpath('//other_id').text.split("/issues/")
    
    return if issue_uri.nil?
    
    issue_base_path = issue_uri[0]
    issue_number = issue_uri[1]
    $ghcli.close_issue(issue_base_path, issue_number)
  end
  
  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end
  
  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials == [settings.basic_user, settings.basic_password]
  end
  
end

# Sinatra Routes
get '/issues/*' do |reponame|
  protected!
  @reponame = reponame
  @issues = fetch_issues reponame, params['labels']
  nokogiri :issues
end

post '/issues' do
  #doc = XmlSimple.xml_in(request.body.read)
  #stories = doc['stories'].first["story"].first
  #current_state = stories["current_state"].first
  #if current_state.eql?"finished" then
  #  issue_uri = stories["other_id"].first.split('/issues/')
  #  issue_base_path = issue_uri[0]
  #  issue_number = issue_uri[1]
  #  $ghcli.close_issue(issue_base_path, issue_number)
  #end
  doc = Nokogiri::XML(request.body.read)
  current_state = doc.xpath('//current_state').text
  if current_state  == "finished" then
    close_issue(doc)
  end
end
