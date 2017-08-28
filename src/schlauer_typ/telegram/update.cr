require "json"
require "./message"

module SchlauerTyp
  module Telegram
    class Update
      JSON.mapping(
        update_id: Int32,
        message: Message
      )
    end
  end
end
