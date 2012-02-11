require 'spec_helper'

describe "sync" do

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
      Capistrano::CLI.ui.stub(:agree) { true }
      subject.should_receive(:download)
      subject.should_receive(:run_locally).with("gunzip --stdout tmp/app-dump.sql.gz | psql -p local-port local-db")
      subject.execute_task(task)
      subject.should have_run("mkdir -p '/shared/app/backup'")
      subject.should have_run("pg_dump -c -Z 9 --no-owner -p #{port} -h #{host} -U #{username} -f /shared/app/backup/app-dump.sql.gz #{database}")
    end

    it "should call proper subtasks" do
      namespace.should_receive(:dump)
      namespace.should_receive(:fetch)
      namespace.should_receive(:import)

      subject.execute_task(task)
    end
  end

  context 'db:fetch task' do
    subject { task }

    its(:description) { should match(/fetch/i) }
  end
end
