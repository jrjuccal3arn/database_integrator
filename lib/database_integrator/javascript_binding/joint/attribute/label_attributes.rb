module DatabaseIntegrator::JavascriptBinding::Joint::Attribute

  class LabelAttributes < Hash

    def fontWeight
      self['font-weight']
    end

    def fontWeight= value
      self['font-weight'] = value
    end

  end

end

