require 'database_integrator/javascript_binding/joint/shape/rectangle'
require 'database_integrator/javascript_binding/joint/attribute/attributes'
require 'database_integrator/javascript_binding/joint/attribute/label_attributes'

module DatabaseIntegrator::JavascriptBinding::Joint

  class ClassDiagramInfo

    attr_accessor :rect, :attrs, :labelAttrs, :label, :shadow, :methods, :swimlane1OffsetY

    def initialize
      self.rect = Rectangle.new x: 260, y: 20, width: 100, height: 40
      self.attrs = Attribute::Attributes.new
      attrs.fill = "green"
      self.labelAttrs = Attribute::LabelAttributes.new
      self.label = ""
      self.shadow = true
      self.methods = []
      self.swimlane1OffsetY = 0
    end

    def set_position(x, y)
      rect.x = x;
      rect.y = y;
    end

    def pack
      maxWidth = 0;
      methods.each do |m|
        if m.length > maxWidth
          maxWidth = m.length
        end
        rect.height += 12
      end
    end

  end

end