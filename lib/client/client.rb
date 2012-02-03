class Client
	
	def run()
		github = GithubAdapter.new(
	                Octokit::Client.new(
	                  :login => opts[:github_user], 
	                  :password => opts[:github_password]))
	end
end