module DatabaseIntegrator
  module DatabaseRepository

    class ColumnMetaInfo

      include DatabaseIntegrator::Util::HashableConstructorSupport

      attr_accessor :name, :type, :primary_key, :foreign_key, :foreign_key_target_table

    end

  end
end