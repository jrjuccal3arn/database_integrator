require "database_integrator/javascript_binding/joint/joint_flow_layout"
require "database_integrator/javascript_binding/joint/joint_context"

module DatabaseIntegrator::JavascriptBinding::Joint

  class JointParser

    def initialize(layout = nil)
      @layout = layout || JointFlowLayout.new
    end

    def parse schema_meta_info
      raise 'Expected a layout engine that implements "do_layout"' unless @layout.respond_to? :do_layout
      joint_context = JointContext.new("world",800,450)
      schema_meta_info.tables.each do |table|
        class_diagram_info = ClassDiagramInfo.new
        class_diagram_info.label = table.name
        class_diagram = ClassDiagram.new class_diagram_info
        table.columns.each do |col|
          add_column(joint_context, class_diagram_info, col, table)
        end
        class_diagram_info.pack
        joint_context.diagrams << class_diagram
      end
      @layout.do_layout joint_context
      joint_context
    end

    private

      def add_column(joint_context, class_diagram_info, col, table)
        column = ""
        if col.primary_key
          column += "* "
        end
        column += "#{col.name}: #{col.type}"
        class_diagram_info.methods << column
        if col.foreign_key
          joint_context.create_association(table.name, col.foreign_key_target_table.name)
        end
      end

  end

end