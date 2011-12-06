require 'spec_helper'

describe "sync" do
  before { subject.load 'deploy' }

  include_context :capistrano

  context 'db task' do
    let(:application) { "app" }
    let(:host) { "host" }
    let(:port) { "port" }
    let(:username) { "username" }
    let(:namespace) { subject.namespaces[:sync].namespaces[:db] }
    let(:database) { "o2h-db" }
    let(:remote_database) { {"database" => database, "host" => host, "port" => port, "username" => username} }
    let(:local_database) { {"database" => "local-db", "port" => "local-port", "username" => "local-username"} }

    before do
      subject.set(:application) { application }
      subject.set(:shared_path) { "/shared/#{application}" }
      namespace.stub(:remote_database_config) { remote_database }
      namespace.stub(:database_config) { local_database }
    end

    it "should set proper repository" do
      subject.should_receive(:download)
      subject.should_receive(:run_locally).with("gunzip --stdout tmp/app-dump.sql.gz | psql -p local-port local-db")
      subject.execute_task(task)
      subject.should have_run("pg_dump -c -Z 9 -p #{port} -h #{host} -U #{username} -f /shared/app/backup/app-dump.sql.gz #{database}")
    end
  end
end
