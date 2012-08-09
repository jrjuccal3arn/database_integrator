module DatabaseIntegrator::JavascriptBinding::Joint

  class Rectangle

    attr_accessor :x, :y, :width, :height

    def initialize attributes
      attributes.each do |k,v|
        self.send("#{k}=",v)
      end
    end

  end

end

