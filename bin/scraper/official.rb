#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full:     noko.css('h4').first.text.gsub('&nbsp', ' ').tidy,
        prefixes: %w[Prime Minister H.E.Dr H.E.Mr H.E.Eng. H.E HE .H.E.Dr H.E.Prof Eng. Mr.]
      ).short
    end

    def position
      noko.css('h3').first.text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.ministercont')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
