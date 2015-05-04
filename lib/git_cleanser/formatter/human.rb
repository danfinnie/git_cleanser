require 'paint'

module GitCleanser
  module Formatter
    class Human
      KEYS = {
        "generated_but_not_ignored" => "These files are compiled but not ignored (maybe they should be added to .gitignore?):",
        "ignored_but_not_generated" => "These files are ignored, but not compiled (maybe they should be added to the compiled files list?):",
        "ignored_but_tracked" => "These files are ignored, but also tracked (maybe they should be removed from the repo or not ignored?):",
        "uncompiled" => "These files look like compilation results, but aren't yet automatically compiled (maybe they should be added to your compiler?):"
      }

      def format(smart_thing)
        KEYS.map do |(key, message)|
          format_message(message) + "\n" + format_list(smart_thing.public_send(key))
        end.join("\n\n")
      end

      private

      def format_message message
        Paint[message, :magenta]
      end

      def format_list list
        if list.any?
          list.map { |file| Paint["  #{file}", :red] }.join("\n")
        else
          Paint["  (no files)", :green]
        end
      end
    end
  end
end
