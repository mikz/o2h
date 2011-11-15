require 'spec_helper'

describe "bluepill" do
  include_context :capistrano

  it "should have bluepill tasks" do
    subject.find_task("bluepill:start").should_not be_nil
  end

  it "performs bluepill:stop before deploy" do
    subject.should callback('bluepill:stop').before('deploy')
  end

  it "performs bluepill:start after deploy" do
    subject.should callback('bluepill:start').after('deploy')
  end

  it "should set :bluepill" do
    subject[:bluepill].should_not be_nil
  end

  context "start task" do
    before {
      subject.load 'deploy'
      subject.set :application, "my-app"
      subject.set :current_path, "current-path"
      subject.set :bluepill, "bluepill"
      subject.set :use_sudo, false
    }

    it "runs bluepill command" do
      subject.find_and_execute_task("bluepill:start")
      subject.should have_run("bluepill load current-path/config/bluepill/production.pill")
    end
  end
end
