require "json"

module SchlauerTyp
  module Telegram
    class MessageEntity
      JSON.mapping(
        type: String,
        offset: Int32
      )
    end
  end
end
