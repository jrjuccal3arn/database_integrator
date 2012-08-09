module DatabaseIntegrator
  module DatabaseRepository

    class SchemaMetaInfo

      include DatabaseIntegrator::Util::HashableConstructorSupport

      attr_accessor :name, :tables

    end

  end
end