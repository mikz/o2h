require 'spec_helper'

describe "git" do
  include_context :capistrano

  its([:scm]) { should == :git }
  its([:branch]) { should == :master }
  its([:deploy_via]) { should == :remote_cache }
  its([:git_shallow_clone]) { should == true }
  its([:git_enable_submodules]) { should == true }
  its([:scm]) { should == :git }

  context 'without application set' do
    it 'call to repository should abort' do
      subject.set(:application) { raise "Not defined" }
      expect { subject[:repository] }.to raise_error("Not defined")
    end
  end

  context 'with application set' do
    it "should set proper repository" do
      subject.set(:application, 'my-app')
      subject.repository == 'git.o2h.cz:my-app'
    end
  end
end
