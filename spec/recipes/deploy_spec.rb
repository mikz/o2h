require 'spec_helper'

describe "deploy" do
  include_context :capistrano

  context "domain my-domain.com" do
    before {
      subject.set :domain, 'my-domain.com'
    }

    its(:deploy_to) { should == '/var/www/my-domain.com' }
    its(:group) { should == :www }

    it "performs set_permissions after deploy" do
      subject.should callback('deploy:set_permissions').after('deploy')
    end

    context 'set_permissions task' do

      it "changes permissions of deploy directory" do
        subject.load 'deploy'
        subject.set :group, 'my-group'
        subject.set :use_sudo, false
        subject.execute_task(task)
        subject.should have_run("chgrp -R my-group #{subject.fetch(:deploy_to)}")
      end
    end
  end
end
