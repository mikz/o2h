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

  context 'configured' do

    before {
      subject.load 'deploy'
      subject.set :bluepill, "bluepill"
      subject.set :use_sudo, false
    }

    context "start task" do

      before {
        subject.set :application, "my-app"
        subject.set :current_path, "current-path"
        subject.set :rails_env, 'my-env'
      }

      let(:task) { subject.find_task('bluepill:start') }

      it "runs bluepill command" do
        subject.execute_task(task)
        subject.should have_run("bluepill load current-path/config/bluepill/my-env.pill")
      end

      it "runs bluepill command in with silverlight env" do
        subject.set :silverlight, true
        subject.execute_task(task)
        env = "LM_CONTAINER_NAME=background_jobs LM_TAG_NAMES=background_jobs:bluepill:#{subject.application}"
        subject.should have_run("#{env} bluepill load current-path/config/bluepill/my-env.pill")
      end

    end

    context 'status task' do
      let(:task) { subject.find_task('bluepill:status') }

      it "runs status command" do
        subject.execute_task(task)
        subject.should have_run("bluepill status")
      end
    end

    context 'stop task' do
      let(:task) { subject.find_task('bluepill:stop') }

      it "runs status command" do
        subject.execute_task(task)
        subject.should have_run("bluepill stop; true")
      end
    end

    context 'quit task' do
      let(:task) { subject.find_task('bluepill:quit') }

      it "runs status command" do
        subject.execute_task(task)
        subject.should have_run("bluepill stop")
        subject.should have_run("bluepill quit")
      end

      it "assings rollback" do
        pending 'no way how to check rollback requests during transaction'
        subject.execute_task(task)
        subject.rollback_requests
      end
    end


  end
end
