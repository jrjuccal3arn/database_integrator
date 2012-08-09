module DatabaseIntegrator
  module DatabaseRepository

  class TableMetaInfo

    include DatabaseIntegrator::Util::HashableConstructorSupport

    attr_accessor :name, :columns

  end

  end
end