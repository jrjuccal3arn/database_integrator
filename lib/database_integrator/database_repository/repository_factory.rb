require "database_integrator/database_repository/adapters/active_record_repository_loader"

module DatabaseIntegrator
  module DatabaseRepository

    class RepositoryFactory

      def create
        if defined? ActiveRecord
          Adapters::ActiveRecordRepositoryLoader.new
        end
      end

      class << self

        def create
          self.new.create
        end

      end

    end

  end
end