module DatabaseIntegrator

  class MainController < DatabaseIntegrator::ApplicationController

    def index
      respond_to do |format|
        format.js do
          repository_loader = DatabaseRepository::RepositoryFactory.create
          schema_meta_info = repository_loader.load
          joint_context = JavascriptBinding::Joint::JointParser.new.parse schema_meta_info
          render inline: joint_context.draw
        end
        format.html
      end
    end

  end

end
