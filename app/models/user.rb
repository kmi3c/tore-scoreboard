class User < ActiveRecord::Base
  dragonfly_accessor :signature
  validates_presence_of :email, :first_name, :last_name, :nickname
  validates_presence_of :p_first_name, :p_last_name, if: :minor?
  before_save :make_signature, if: :signature_json?
  before_save :set_days, :store_score
  serialize :days, Hash
  scope :today, ->{where('days like ?',"%#{Time.zone.now.to_date}: \"-\"%")}
  def score=(value)
    super(score+value.to_i)
  end
  def today_score
    days[today]
  end
  def today
    Time.zone.now.to_date
  end
  def self.user_days
    start_day = '2015-11-08'.to_date
    days = {}
    (1..5).each{|i| days[start_day+i.day] = "DAY #{i}"}
    days[start_day+6.days] = "FINALE"
    days[start_day+7.days] = "TOTAL"
    days
  end

  def minor?
    !adult?
  end
  private
  def make_signature
   if signature_json_changed?
      require 'open3'
      instructions = JSON.parse(signature_json).map { |h| "line #{h['mx'].to_i},#{h['my'].to_i} #{h['lx'].to_i},#{h['ly'].to_i}" } * ' '
      tempfile = Tempfile.new(["user_signature", '.png'])
      Open3.popen3("convert -size 198x55 xc:transparent -stroke blue -draw @- #{tempfile.path}") do |input, output, error|
        input.puts instructions
      end
      self.signature = tempfile
      self.signature_name = "#{email.gsub('@','_at_').gsub('.','_')}_signature.png"
    end
  end
  def set_days
    if days == {}
      default = {}
      User.user_days.keys.reverse.drop(1).reverse.each{|day| default[day] = '-'}
      self.days = default
    end
  end
  def store_score
    if score_changed?
      days[today] = days[today].to_i + (score_change[1]-score_change[0])
    end
  end
end
