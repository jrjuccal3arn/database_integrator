module DatabaseIntegrator::DatabaseRepository

  module Adapters

    class ActiveRecordRepositoryLoader

      def load
        models = find_persistence_models
        schema_meta_info = DatabaseIntegrator::DatabaseRepository::SchemaMetaInfo.new tables: []
        models.each do |model|
          schema_meta_info.tables << deep_set(model,schema_meta_info)
        end
        schema_meta_info
      end

      def deep_set(model,schema_meta_info)
        table_meta_info = DatabaseIntegrator::DatabaseRepository::TableMetaInfo.new name: model.name, columns: []
        model.columns.each do |col|
          column_meta_info = DatabaseIntegrator::DatabaseRepository::ColumnMetaInfo.new
          column_meta_info.name = col.name
          column_meta_info.type = col.sql_type
          column_meta_info.primary_key = col.primary
          if foreign_key_regexp = /(.+)_id/.match(col.name)
            column_meta_info.foreign_key = foreign_key_regexp.present?
            belongs_to_ref_name = foreign_key_regexp[1].to_sym
            column_meta_info.foreign_key_target_table = deep_set(model.reflect_on_association(belongs_to_ref_name).klass,schema_meta_info)
          end
          table_meta_info.columns << column_meta_info
        end
        table_meta_info
      end

      private

        def find_persistence_models
          find_models.select do |model|
            model.ancestors.include? ActiveRecord::Base
          end
        end

        def find_models
          @@system_models ||= # memoization for tests
              ([Rails.application] + Rails::Application::Railties.engines).map do |app|
                (app.paths['app/models'] + app.config.autoload_paths).map do |load_path|
                  Dir.glob(app.root.join(load_path)).map do |load_dir|
                    Dir.glob(load_dir + "/**/*.rb").map do |filename|
                      # app/models/module/class.rb => module/class.rb => module/class => Module::Class
                      lchomp(filename, "#{app.root.join(load_dir)}/").chomp('.rb').camelize.constantize
                    end
                  end
                end
              end.flatten
        end

        def lchomp(base, arg)
          base.to_s.reverse.chomp(arg.to_s.reverse).reverse
        end

    end

  end

end