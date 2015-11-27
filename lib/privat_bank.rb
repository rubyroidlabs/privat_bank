require 'privat_bank/version'
require 'money'
require 'open-uri'
require 'json'

class Money
  module Bank
    class PrivatBank < Money::Bank::VariableExchange
      SERVICE_HOST = 'api.privatbank.ua'
      SERVICE_PATH = '/p24api/pubinfo'
      SERVICE_QUERY = 'json&exchange&coursid=5'

      def update_rates
        update_parsed_rates(daily_exchange_rates)
        @rates
      end

      private

      def uri
        URI::HTTPS.build(host: SERVICE_HOST, path: SERVICE_PATH, query: SERVICE_QUERY)
      end

      def daily_exchange_rates
        JSON.parse(uri.read)
      end

      def update_parsed_rates(rates)
        add_rate('UAH', 'UAH', 1)
        rates.each do |rate|
          begin
            if local_currencies.include?(rate['ccy'])
              add_rate(rate['base_ccy'], rate['ccy'], 1 / rate['sale'].to_f)
              add_rate(rate['ccy'], rate['base_ccy'], rate['sale'].to_f)
            end
          rescue Money::Currency::UnknownCurrency
          end
        end
      end

      def local_currencies
        @local_currencies ||= Money::Currency.table.map { |currency| currency.last[:iso_code] }
      end
    end
  end
end
