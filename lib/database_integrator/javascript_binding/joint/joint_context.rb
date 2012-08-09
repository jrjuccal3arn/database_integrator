module DatabaseIntegrator::JavascriptBinding::Joint

  class JointContext

    attr_accessor :width, :height, :diagrams

    def initialize(dom_element_id, width, height)
      @builder = ""
      @associations_builder = ""
      @diagrams = []
      @dom_element_id = dom_element_id
      self.width = width
      self.height = height
    end

    class << self

      def to_var_name any
        any.to_s.underscore.gsub("/","_")
      end

    end

    def create_draw_area
      @builder += %[Joint.paper("#{@dom_element_id}", #{width}, #{height}); \n ]
    end

    def create_association(diagram_source, diagram_target)
      @associations_builder += %{ #{self.class.to_var_name(diagram_source)}.joint(#{self.class.to_var_name(diagram_target)}, Joint.dia.uml.aggregationArrow).register([#{(self.class.to_var_name(diagram_target))}]); \n }
    end

    def draw_diagrams
      @builder += diagrams.map(&:to_json).join("\n") + "\n"
      @builder += "var all = [#{diagrams.map { |d| self.class.to_var_name(d.name) }.join(",") }] \n"
      @builder += @associations_builder
    end

    def draw
      create_draw_area
      draw_diagrams
    end

    def to_json
      @builder
    end

  end

end