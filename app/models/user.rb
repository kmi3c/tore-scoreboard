class User < ActiveRecord::Base
  include ImportExport
  include QueryFilter
  dragonfly_accessor :signature
  validates_presence_of :email, :first_name, :last_name, :nickname,:signature, :accept_r, :accept_m, {message: 'Non può essere vuoto'}
  validates_uniqueness_of :email, :nickname
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_presence_of :p_first_name, :p_last_name, if: :minor?
  before_validation :make_signature, if: :signature_json?
  before_save :store_score, :check_total
  serialize :days, Hash
  scope :today, ->{where('day like ?')}
  def today_score
    self.send(today_method)
  end
  def today_method
    days[today].nil? ? 'score' : days[today].gsub(' ','').downcase
  end
  def today
    Time.zone.now.to_date
  end
  def self.user_days
    start_day = '2015-11-16'.to_date
    days = {}
#    (0..4).each{|i| days["DAY #{i+1}"] = start_day+i.day}
#    days["FINALE"] = start_day+5.days
#    days["TOTAL"]  = start_day+6.days
    days["DAY 1"]  = start_day+1.day
    days["DAY 2"]  = start_day+2.day
    days["DAY 3"]  = '2016-01-19'.to_date
    days["DAY 4"]  = days["DAY 3"]+1.day
    days["DAY 5"]  = days["DAY 4"]+1.day
    days["FINALE"] = days["DAY 5"]+1.day
    days["TOTAL"]  = days["FINALE"]+1.day
    days
  end
  def name
    "#{first_name} #{last_name} [#{nickname}]"
  end
  def to_s
    name
  end
  def signature_url
    signature.url if signature_stored?
  end
  def days
    User.user_days.except('TOTAL').invert
  end
  def minor?
    !adult?
  end
  def total
    self.attributes.values_at(*['day1','day2','day3','day4','day5','finale']).compact.inject(&:+)
  end

  def make_signature
   if signature_json_changed?
      make_signature!
    end
  end
  def make_signature!
    require 'open3'
    instructions = JSON.parse(signature_json).map { |h| "line #{h['mx'].to_i},#{h['my'].to_i} #{h['lx'].to_i},#{h['ly'].to_i}" } * ' '
    tempfile = Tempfile.new(["user_signature", '.png'])
    Open3.popen3("convert -size 720x200 xc:transparent -stroke black -strokewidth 4 -draw @- #{tempfile.path}") do |input, output, error|
      input.puts instructions
    end
    self.signature = tempfile
    self.signature_name = "#{email.gsub('@','_at_').gsub('.','_')}_signature.png"
  end  
  def store_score
    if score_changed?
      self.send(today_method+'=', score_change[1]-score_change[0])
    end
  end
  def check_total
    self.score = self.total if self.score != self.total
  end
end
