module SchlauerTyp
  module Resources
    BASE_PATH = {{ env("BASE_PATH") || "/" }}
    CACHE_BUSTER = {{ run("./resource_helpers/cache_buster") }}

    LOGOS = {} of String => String
    FAVICONS = {} of String => String
    JS = {{ run("./resource_helpers/load_resource", "app.js") }}

    {% for format in %w(png svg) %}
      {% LOGOS["logo.#{format.id}"] = run("./resource_helpers/load_resource", "logo.#{format.id}") %}
    {% end %}

    {% begin %}
      \{% for file in {{ run("./resource_helpers/favicon_files") }} %}
         \{% FAVICONS[file] = run("./resource_helpers/load_resource", file) %}
      \{% end %}
    {% end %}

    module MessageData
      START = {{ run("./resource_helpers/load_yaml", "message_parts.yml", "start") }}
      MIDDLE = {{ run("./resource_helpers/load_yaml","message_parts.yml", "middle") }}
      END = {{ run("./resource_helpers/load_yaml","message_parts.yml", "end") }}
    end
  end
end
