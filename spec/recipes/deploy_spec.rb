require 'spec_helper'

describe "deploy" do
  before { subject.load('deploy') }
  include_context :capistrano

  let(:deploy) { subject.namespaces[:deploy] }

  context "domain my-domain.com" do
    before {
      subject.set :domain, 'my-domain.com'
    }

    its(:deploy_to) { should == '/var/www/my-domain.com' }
    its(:group) { should == :www }

    it "performs set_permissions after deploy" do
#      raise deploy.callbacks[:after].inspect
      deploy.should callback(:set_permissions).after(:update_code)
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
