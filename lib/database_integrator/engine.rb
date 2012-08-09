require 'rails'
require 'database_integrator/database_repository'
require 'database_integrator/javascript_binding'
require 'database_integrator/javascript_binding/joint/joint'

module DatabaseIntegrator
    class Engine < ::Rails::Engine
      isolate_namespace DatabaseIntegrator
    end
end
