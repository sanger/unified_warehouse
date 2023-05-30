# frozen_string_literal: true

# In order to conform with zeitwerk loading conventions we need this file

# To keep the warren namespace we need this
app_warren_dir = Rails.root.join('app/warren').to_s
ActiveSupport::Dependencies.autoload_paths.delete(app_warren_dir)
Rails.application.config.watchable_dirs[app_warren_dir] = [:rb]

# Ignore generators as they arent needed to be autoloaded by the application
Rails.autoloaders.main.ignore(Rails.root.join('lib/generators'))
