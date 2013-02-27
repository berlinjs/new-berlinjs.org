module Jekyll

  class TalkCollector < Jekyll::Generator
    safe true
    priority :lowest

    def initialize(config)
    end

    def generate(site)
      config = site.config

      config['talks'] = talks = {}

      site.posts.each do |post|
        ug = (talks[post.data['ug']] ||= {})
        meetup = (ug[post.date.to_date] ||= {})
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
    end
  end
end
