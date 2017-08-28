require "./resources"

module SchlauerTyp
  class MessageGenerator
    START = Resources::MessageData::START
    MIDDLE = Resources::MessageData::MIDDLE
    END = Resources::MessageData::END
    DEFAULT_LOCALE = ENV["DEFAULT_LOCALE"]? || "en"

    def get_message(start_index, middle_index, end_index, locale = DEFAULT_LOCALE)
      locale = "en" unless ["de", "en"].includes?(locale)
      "#{START[locale][start_index % START[locale].size]} " \
      "#{MIDDLE[locale][middle_index % MIDDLE[locale].size]} " \
      "#{END[locale][end_index % END[locale].size]}"
    end

    def generate_path(locale = DEFAULT_LOCALE)
      start_index = rand(START[locale].size)
      middle_index = rand(MIDDLE[locale].size)
      end_index = rand(END[locale].size)

      "/#{locale}/#{start_index}/#{middle_index}/#{end_index}"
    end
  end
end
