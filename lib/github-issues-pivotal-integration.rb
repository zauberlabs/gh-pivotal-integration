require 'octokit'
require 'ostruct'
require 'logger'

class GithubAdapter

	def initialize(client)
		@client = client
	end

	def issues
		issues = []
		begin
		  issues << @client.list_issues( reponame, :page => page, :state => :open )
		  page += 1
		end until issues[-1].length != 10
		issues.flatten
	end
end

class XMLBuilder

	def build(issues)
		builder = Nokogiri::XML::Builder.new do |xml|
			xml.external_stories {
				issues.each do |issue|
					xml.external_story {
						xml.external_id issue["id"]
						xml.name issue["title"]
						xml.description issue["description"]
						xml.requested_by issue["user"]["login"]
						xml.created_at issue["created_at"]
						xml.story_type "bug"
						xml.estimate 0
					}
				end
			}
		end
	end

end