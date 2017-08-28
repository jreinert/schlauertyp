require "http/client"
require "./telegram/update"
require "./telegram/send_message"
require "./telegram/set_webhook"
require "./message_generator"

module SchlauerTyp
  class TelegramBot
    HOST_NAME = ENV["HOST_NAME"]
    BASE_URL = "https://api.telegram.org/bot#{ENV["TELEGRAM_BOT_TOKEN"]}/"
    COMMAND_REGEX =
      /(?<command>#{Regex.escape(ENV["TELEGRAM_BOT_COMMAND"])})(?:$| |(?<nick>@\w+))/

    def initialize(@generator : MessageGenerator)
      setup_webhook(ENV["TELEGRAM_WEBHOOK_TOKEN"])
    end

    def setup_webhook(webhook_token)
      webhook_url = "https://#{HOST_NAME}/telegram/#{webhook_token}"
      body = Telegram::SetWebhook.new(webhook_url).to_json
      headers = HTTP::Headers{"Content-Type" => "application/json"}
      HTTP::Client.post(
        "#{BASE_URL}setWebhook", headers: headers, body: body
      ) do |response|
        raise response.body_io.gets_to_end unless response.success?
      end
    end

    def bot_command?(update)
      message_entities = update.message.entities
      return false unless message_entities && message_entities.size == 1
      message_entity = message_entities.first
      return false unless message_entity.type == "bot_command" && message_entity.offset == 0
      text = update.message.text
      return false unless text
      match = text.match(COMMAND_REGEX)
      return false unless match
      return false unless [nil, "@#{ENV["TELEGRAM_BOT_NICK"]}"].includes?(match["nick"]?)

      true
    end

    def handle_update(context)
      return unless context.params.url["token"] == ENV["TELEGRAM_WEBHOOK_TOKEN"]
      body = context.request.body
      return unless body
      update = Telegram::Update.from_json(body)
      return unless bot_command?(update)
      text = update.message.text || ""
      locale = text.strip.split(" ")[1]? ||
        MessageGenerator::DEFAULT_LOCALE

      url = "https://#{HOST_NAME}#{@generator.generate_path(locale)}"
      send_message = Telegram::SendMessage.new(update.message.chat.id, url)
      context.response.headers["Content-Type"] = "application/json"
      send_message.to_json(context.response)
    end
  end
end
