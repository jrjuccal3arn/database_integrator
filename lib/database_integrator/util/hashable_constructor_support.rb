module DatabaseIntegrator
  module Util

    module HashableConstructorSupport

      def _bind_to_instance_attributes hash
        raise 'Expected hash' unless hash.is_a? Hash
        hash.each do |k,v|
          v = _bind_to_instance_attributes v if v.is_a? Hash
          self.instance_variable_set("@#{k}",v)
        end
        self
      end

      def initialize(hash = {})
        _bind_to_instance_attributes hash
      end

    end

  end
end