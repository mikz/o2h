require 'capistrano/recipes/deploy/strategy/remote'

module Capistrano
  module Deploy
    module Strategy

      # Implements the deployment strategy which does an SCM checkout on each
      # target host. This is the default deployment strategy for Capistrano.
      class Git < Remote
        def clone!
          scm_run clone
        end

        def deploy!
          scm_run sync
        end

        protected

          def clone
            @clone ||= source.checkout(revision, configuration[:release_path])
          end

          # Returns the SCM's checkout command for the revision to deploy.
          def sync
            @sync ||= source.sync(revision, configuration[:release_path])
          end
      end

    end
  end
end
