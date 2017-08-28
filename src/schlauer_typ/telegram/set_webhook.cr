require "json"

module SchlauerTyp
  module Telegram
    class SetWebhook
      JSON.mapping(
        url: String,
        allowed_updates: Array(String)
      )

      def initialize(@url)
        @allowed_updates = ["message"]
      end
    end
  end
end
