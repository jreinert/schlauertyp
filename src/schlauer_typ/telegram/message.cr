require "json"
require "./message_entity"
require "./chat"

module SchlauerTyp
  module Telegram
    class Message
      JSON.mapping(
        message_id: Int32,
        entities: Array(MessageEntity)?,
        chat: Chat,
        text: String?
      )
    end
  end
end
