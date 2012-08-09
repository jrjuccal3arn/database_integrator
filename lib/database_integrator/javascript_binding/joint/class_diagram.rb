module DatabaseIntegrator::JavascriptBinding::Joint

  class ClassDiagram

    attr_reader :class_diagram_info, :name

    def initialize class_diagram_info
      @class_diagram_info = class_diagram_info
      @name = class_diagram_info.label
    end

    def to_json
      "var #{JointContext.to_var_name(name)} = Joint.dia.uml.Class.create(#{class_diagram_info.to_json});\n";
    end

  end

end