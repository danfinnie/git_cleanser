module GitCleanser
  module Formatter
    class YAML
      KEYS = ["generated_but_not_ignored", "ignored_but_not_generated", "ignored_but_tracked", "uncompiled"]

      def format(smart_thing)
        output = KEYS.inject({}) { |memo, this| memo[this] = smart_thing.public_send(this); memo }
        ::YAML.dump(output).strip
      end
    end
  end
end
