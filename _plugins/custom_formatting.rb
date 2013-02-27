module Jekyll
  module FancyDateFilter

    def fancy_date_format(input)
      if input.methods.include? :strftime
        output = input.strftime('%B %-d<sup>')
        if output[-7] == '1'
          output += 'th'
        else
          case output[-6]
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
        output += '</sup>'
        output
      else
        input
      end
    end


    ##<span class="month">Feb</span>
    ##<span class="day">28<sup>th</sup></span>
    def fancy_short_date_format(input)
      if input.methods.include? :strftime
        output = input.strftime('<span class="month">%b</span> <span class="day">%-d<sup>')
        if output[-7] == '1'
          output += 'th'
        else
          case output[-6]
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
        output += '</sup></span>'
        output
      else
        input
      end
    end

  end
end

Liquid::Template.register_filter(Jekyll::FancyDateFilter)
