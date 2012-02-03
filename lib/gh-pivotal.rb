require 'octokit'
require 'nokogiri'
require 'sinatra'

def issues(client, reponame)
  issues = []
  page = 0
  begin
    issues << client.list_issues( reponame, :page => page, :state => :open )
    page += 10
  end until issues[-1].length != 10
  issues.flatten
end

def to_xml(issues, reponame) 
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.external_stories(:type => "array") {
      issues.each do |issue|
        xml.external_story {
          xml.external_id "#{reponame}/issues/#{issue["number"]}"
          xml.name issue["title"]
          xml.description issue["description"]
          xml.requested_by issue["user"]["login"]
          xml.created_at(issue["created_at"], :type => "datetime")
          xml.story_type "bug"
          xml.estimate 0
        }
      end
    }
  end
  builder.to_xml
end


ghcli = Octokit::Client.new :login => "mcortesi" , :password => "m1234567"

get '/issues/:account/:reponame' do
  fullname = "#{params[:account]}/#{params[:reponame]}"
  to_xml(issues(ghcli, fullname), fullname)
end

