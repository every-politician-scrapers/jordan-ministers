#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full:     fullname,
        prefixes: %w[Prime Minister H.E.Dr H.E.Mrs H.E.Mr H.E.Eng. H.E HE .H.E.Dr H.E.Prof Eng. Mr.]
      ).short
    end

    def position
      noko.xpath('preceding::h3[1]').text.tidy
    end

    private

    def fullname
      noko.text.gsub('&nbsp', ' ').tidy
    end
  end

  class Members
    def member_container
      noko.css('#Container h4')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
