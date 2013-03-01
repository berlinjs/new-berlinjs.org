module Jekyll

  class TalkCollector < Jekyll::Generator
    safe true
    priority :lowest

    def initialize(config)
    end

    def generate(site)
      config = site.config

      config['ugs'].select! {|page| page["layout"] == 'ug'}

      config['talks'] = talks = {}
      config['meetups'] = meetups = []

      site.posts.each do |post|
        ug = (talks[post.data['ug']] ||= {})
        post_date = post.date.to_date
        if ug.key? post_date
          meetup = ug[post_date]
        else
          ug_page = config['ugs'].select {|ug| ug['class'] == post.data['ug']}[0]
          meetup = ug[post_date] = {"date" => post_date, "ug" => ug_page}
          meetups << meetup
        end
        slot, title = post.slug.split '-', 2
        if title === nil
          title = slot
          slot = 1
          until meetup[slot] === nil
            slot+= 1
          end
        end
        slot = Integer(slot)
        post.data['title'] = title
        post.data['slot'] = slot
        meetup[slot] = post
      end

      config['ugs'].each do |ug|
        ug_talks = (talks[ug['class']] ||= {})
        next_date = ug['next_date']
        puts '%s: %s' % [ug['class'], next_date]
        if ug_talks[next_date] === nil
          puts "  no talks yet, creating empty meetup..."
          meetups << (ug_talks[next_date] = {"date" => next_date, "ug" => ug})
        end
      end

      meetups.sort {|a,b| a["date"] <=> b["date"] }
      today = site.time.to_date
      config['next_meetups'] = meetups.select {|m| m["date"] >= today}
    end
  end
end
