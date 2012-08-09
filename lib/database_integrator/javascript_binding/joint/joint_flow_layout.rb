module DatabaseIntegrator::JavascriptBinding::Joint

  class JointFlowLayout

    def do_layout joint_context
      margin, positionX, positionY = 10, 0, 0
      joint_context.diagrams.each do |diagram|
        diagram.class_diagram_info.set_position positionX, positionY
        positionX += margin + diagram.class_diagram_info.rect.width;
      end
    end

  end

end

