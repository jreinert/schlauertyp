require "json"

module SchlauerTyp
  module Telegram
    class SendMessage
      JSON.mapping(
        method: String,
        chat_id: Int64,
        text: String
      )

      def initialize(@chat_id, @text)
        @method = "sendMessage"
      end
    end
  end
end
