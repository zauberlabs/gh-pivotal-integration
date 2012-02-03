require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require "mocha"
require "ostruct"

describe "GithubAdapter" do

	before :each  do 
    @client = double()
    @github = GithubAdapter.new(@client)
    end

    describe "list_issues" do
    end

end