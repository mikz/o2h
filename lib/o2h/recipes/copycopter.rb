namespace :copycopter do
  task :deploy do
    run_locally "rake copycopter:deploy"
  end
end
