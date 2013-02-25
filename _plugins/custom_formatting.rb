module Jekyll
  module FancyDateFilter
    def fancy_date_format(input)
      if input.methods.include? :strftime
        output = input.strftime('%B %-d')
        if output[-2] == '1'
          output += 'th'
        else
          case output[-1]
          when '1'
            output += 'st'
          when '2'
            output += 'st'
          when '3'
            output += 'rd'
          else
            output += 'th'
          end
        end
        if input.year != Date.today.year
          output += input.strftime(', %Y')
        end
        output
      else
        input
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::FancyDateFilter)
