require 'spec_helper'

describe "GitMyCurriculums" do
  describe "GET /git_my_curriculums" do
    it "display some users" do
    	visit users_path
    	page.should have_content 'Bailey Ammons'
    end
  end
end
