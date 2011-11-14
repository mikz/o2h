require 'spec_helper'

describe "bluepill" do
  include_context :capistrano

  it "should have bluepill tasks" do
    subject.find_task("bluepill:start").should_not be_nil
  end

  it "should set :bluepill" do
    subject[:bluepill].should_not be_nil
  end
end
