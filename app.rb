module Nesta
  class App

    helpers do
      def is_post?
        @page.date
      end

      def is_page?
        return true if @page.date.nil?
      end

      def is_category?
        return true unless @page.articles.empty?
      end

      # Pulled from Rails
      # http://apidock.com/rails/ActiveSupport/Inflector/ordinalize
      def ordinalize(number)
        if (11..13).include?(number.to_i.abs % 100)
          "#{number}th"
        else
          case number.to_i.abs % 10
            when 1; "#{number}st"
            when 2; "#{number}nd"
            when 3; "#{number}rd"
            else    "#{number}th"
          end
        end
      end

      # Overide Nesta's method
      def format_date(date)
        date.strftime("%B #{ordinalize('%e')}, %Y")
      end
    end

  end
end
