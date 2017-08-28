require "json"

module SchlauerTyp
  module Telegram
    class Chat
      JSON.mapping(
        id: Int64
      )
    end
  end
end
